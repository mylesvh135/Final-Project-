function [] = titrationProgram()
close all;
global gui;
gui.fig = figure;
gui.p = plot(0,0);
gui.p.Parent.Position = [0.2 0.2 0.6 0.6];

%the figure is now created from the code above in the gui

gui.button = uicontrol('style','pushbutton','units','normalized','position',[0.8 0.1 0.1 0.05],'string','Plot pH',...
    'callback',{@plotpHFunction});
gui.button = uicontrol('style','pushbutton','units','normalized','position',[0.1 0.1 0.1 0.05],'string','Plot pOH',...
    'callback',{@plotpOHFunction});
gui.VbEdit = uicontrol('style','edit','units','normalized','position',[0.1 0.8 0.1 0.05]);

gui.MbEdit = uicontrol('style','edit','units','normalized','position',[0.2 0.8 0.1 0.05]);

gui.MaEdit = uicontrol('style','edit','units','normalized','position',[0.7 0.8 0.1 0.05]);

gui.VaEdit = uicontrol('style','edit','units','normalized','position',[0.8 0.8 0.1 0.05]);

gui.Vbtext = uicontrol('style','text','units','normalized','position',[0.1 0.85 0.1 0.08],...
    'string','Base Volume');

gui.Mbtext = uicontrol('style','text','units','normalized','position',[0.2 0.85 0.1 0.08],...
    'string','Base Molarity');

gui.Matext = uicontrol('style','text','units','normalized','position',[0.7 0.85 0.1 0.08],...
    'string','Acid Molarity');

gui.Vatext = uicontrol('style','text','units','normalized','position',[0.8 0.85 0.1 0.08],...
    'string','Acid Volume');

gui.titletext = uicontrol('style','text','units','normalized','position',[0.45 0.8 0.1 0.08],...
    'string','Titration Graph');

%from all the above code, all the elements within the gui are created 


end

function [] = plotpHFunction(~,~)
global gui;
Vb = str2double(gui.VbEdit.String);
Mb = str2double(gui.MbEdit.String);
Ma = str2double(gui.MaEdit.String);
Va = str2double(gui.VaEdit.String);
pH = pHCalculator(Mb,Ma,Vb,Va);
gui.p = plot(Vb, pH,'bx');

end

%plotpHFunction creates the callback button for plotting pH over Vb

function [] = plotpOHFunction(~,~)
global gui;
Vb = str2double(gui.VbEdit.String);
Mb = str2double(gui.MbEdit.String);
Ma = str2double(gui.MaEdit.String);
Va = str2double(gui.VaEdit.String);
pOH = pOHCalculator(Mb,Ma,Vb,Va);
gui.p = plot(Va, pOH,'r*');

end

%plotpOHFunction creates the callback for button for plotting pOH over Va


function [pH] = pHCalculator(Mb,Ma,Vb,Va)
%this function will determine pH

beforeEquilH = ((Ma * Va) - (Mb * Vb))/(Vb + Va);
%the above expression gives the H+ concentration before the
%equilibrium point

afterEquilOH = ((Mb * Vb) - (Ma * Va))/(Vb + Va);
%the above line gives concentration of OH since after equilibrium all
%the H+ is expended

if Mb*Vb < Ma*Va %this if statement is necessary because pH is calculated differently
    % before and after equilibrium
    
    pH = -log10(beforeEquilH);
    
    
elseif Mb*Vb == Ma*Va
    % when dealing with strong acids and bases, pH and equilibrium is always 14
    pH = 7;
    
else
    %after equilibrium, pOH must be calculated since only OH is
    %remaining
    pH = 14 + log10(afterEquilOH);
    
    
end



end


function [pOH] = pOHCalculator(Mb,Ma,Vb,Va)

beforeEquilOH = (((Mb*Vb) - (Ma*Va))/(Vb+Va));

afterEquilH = (((Ma*Va) - (Mb*Vb))/(Vb+Va));

if Ma*Va < Mb*Va
    
    pOH = -log(beforeEquilOH);
    
elseif Ma*Va == Mb*Vb
    
    pOH = 7;
    
else
    
    pOH = 14 + log(afterEquilH);
    
end

end

%the above pOH calculation function will make you able to calculate for pOH
%over Va, which is not very practical... but I needed another callback
%function... :)





