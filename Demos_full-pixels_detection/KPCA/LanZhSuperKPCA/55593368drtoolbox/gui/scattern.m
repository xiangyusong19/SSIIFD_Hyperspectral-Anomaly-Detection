% This file is part of the Matlab Toolbox for Dimensionality Reduction v0.7b.
% The toolbox can be obtained from http://ticc.uvt.nl/~lvdrmaaten
% You are free to use, change, or redistribute this code in any way you
% want for non-commercial purposes. However, it is appreciated if you 
% maintain the name of the original author.
%
% (C) Laurens van der Maaten
% Tilburg University, 2008

function scattern(name,data,varargin)
% scatter plot if dimensionality>=3
% format: scattern(name,data) 
% name - text that will be dispayed as name of figure
% data - multidimentional data, row - is one datapoint
% scattern(name,data,labels) - if labels spacified, used for color of points 

bgc=[0.8313725490196079 0.8156862745098039 0.7843137254901961];
bgc1=[1 1 1];
bgc1=bgc;

if length(varargin)==1
    labels=varargin{1};
    islb=true;
else
    islb=false;
end

hf=figure;
set(hf,'name',name,'NumberTitle','off');
set(hf,'units','normalized');
set(hf,'position',[0.1 0.1 0.7 0.75]);
set(hf,'color',bgc);
ha=axes;
set(ha,'units','normalized');
set(ha,'position',[0.1 0.1 0.8 0.7]);
if islb && size(data, 1) == numel(labels)
    hs=scatter3(data(:,1),data(:,2),data(:,3),5,labels,'parent',ha);
else
    hs=scatter3(data(:,1),data(:,2),data(:,3),5,'parent',ha);
end
if size(data, 1) ~= numel(labels)
    warning('The GUI cannot yet deal properly with disconnected parts in the neighborhood graph.');
end

set(hs,'UserData',data); % memorize data in userdata of plot

% title as text contol:
xc=0.5;
yc=0.94;
dx=0.8;
dy=0.04;
uicontrol('Style', 'text',...
       'parent',hf,...
       'String', name,...
       'units','normalized',...
       'fontunits','normalized',...
       'HorizontalAlignment','center',...
       'Position', [xc-dx/2 yc dx dy],...
       'backgroundcolor',bgc1);

% dimensionality text
xc=0.5;
yc=0.9;
dx=0.2;
dy=0.04;
uicontrol('Style', 'text',...
       'parent',hf,...
       'String', ['dimensionality=' num2str(length(data(1,:)))],...
       'units','normalized',...
       'fontunits','normalized',...
       'Position', [xc-dx/2 yc dx dy],...
       'backgroundcolor',bgc1);

% edits:
xc=0.5;
yc=0.86;
dy=0.04;
dytx=0.03;
x0=0.12;
dxg=0.05;
xt=x0;
for cc=1:3
    switch cc
        case 1
            ls='X';
        case 2
            ls='Y';
        case 3
            ls='Z';
    end
    
    dx1=0.07;
    uicontrol('Style', 'text',...
           'parent',hf,...
           'String', [ls ' ' 'data:'],...
           'units','normalized',...
           'fontunits','normalized',...
           'Position', [xt yc-dytx/2 dx1 dytx],...
           'backgroundcolor',bgc1);
       
    xt=xt+dx1+0.005;
    
    dx1=0.07;
    he=uicontrol('Style', 'edit',...
           'parent',hf,...
           'String', num2str(cc),...
           'units','normalized',...
           'fontunits','normalized',...
           'Position', [xt yc-dy/2 dx1 dy],...
           'backgroundcolor',[1 1 1]);
       
    set(he,'callback',['ded(' num2str(cc) ',' num2str(hs,'%20.20f') ',' num2str(he,'%20.20f') ')']);
       
    xt=xt+dx1+0.005;
    
    
    dx1=0.065;
    uicontrol('Style', 'text',...
           'parent',hf,...
           'String', 'column',...
           'units','normalized',...
           'fontunits','normalized',...
           'Position', [xt yc-dytx/2 dx1 dytx],...
           'backgroundcolor',bgc1);
       
    xt=xt+dx1+0.005;
    
    xt=xt+dxg;
end


xlabel(ha,'X');
ylabel(ha,'Y');
zlabel(ha,'Z');

set(hf,'Toolbar','figure');

