function vecmesh = vecmesh(filename, varargin)
% The function vecmesh is designed to explore the complexity of rhythmic
% relations within the vecmesh. It accomplishes this by plotting graphs
% that showcase the rhythmic vectors and their connections. To select the
% data to be plotted, you can uncomment the desired command in "proflist"
% file or freely create variations based on the given examples. Before
% running the script, ensure that the files profdata.mat and reldata.mat
% are located in the same folder as the script to ensure smooth execution.
%
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright ©2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ========== Importing variables
load ('relvecs.mat', 'relvecs');
load ('vecdata.mat', 'vecdata');
% ========== 3. Extracton of variables and vectors
names = table(vecdata.vstrings);
s = relvecs.svec; % porder of start profiles
t = relvecs.tvec; % porder of target profiles
rels = relvecs.vrels; % relations between s and t profiles.
weights = ones(1,size(s,1))'; % weights flattened to one
% ========== 4. Graph data rendering (disabled)
G = graph(s, t, weights, names);
% ========== 5. Load options for subgraphs
% Load the list of profiles contained in the script proflist.m.
eval(filename);
perfs = sort(perfs);
vinds = unique(pnvector(pcodes(perfs)));
% ========== 6. Subgraph data rendering
H = subgraph(G, vinds);
% ========== Subgraph colors ==========
styles = [  {'-'};...
            {'-'};...
            {'-'};...
            {':'};...
            {':'};...
            {':'}];
colors = [  .75 0 0;...
            0 .75 0;...
            0 0 .75;...
            .75 0 0;...
            0 .75 0;...
            0 0 .75];
% ========== Render Figure
% ========== 7. Extraction of relations for subgraph
HE = H.Edges(:,1);
reltab = table2array(HE);
globalrels = table2array(relvecs(:,1:2));
inds = [];
    for f = 1:size(reltab,1)
        temprel = globalrels(f,:);
        ind = ismember(globalrels(f,:), temprel, 'rows');
        if ind == 1
            inds = [inds; f];
        end
    end
    rels = globalrels(inds,:);
    indc = table2array(relvecs(inds,3));
% ==========
FG = figure('Renderer','Painters');
grid on
GH = plot(H,...
            'EdgeColor', colors(indc,:),...
            'NodeColor', 'k',...
            'LineStyle', styles(indc,:),...
            'Layout','force3',...
            'UseGravity', true,...
            'LineWidth', 1.5);
%legend(num2str(unique(indc)), 'Location', 'east');
hold on
% ========== Change coordinates ==========
    if sum(contains(varargin, 'space'))==1
    [~, ~, c] = intersect(names, H.Nodes, 'rows');
    H.Nodes
    vectab = pcoord(c);
    x = vectab(:,1)';
    y = vectab(:,2)';
    z = vectab(:,3)';
    GH.XData = x;
    GH.YData = y;
    GH.ZData = z;
    GH.NodeLabel = {};
    names = table2array(names);
    names = names(vinds,:);
    text(x+.04, y+.04, z+.04, names)
    GH.DataTipTemplate.DataTipRows(1).Label = 'Profile';
    GH.DataTipTemplate.DataTipRows(2).Label = 'Position';
    GH.DataTipTemplate.DataTipRows(2).Value = string(y);
    hold off
    end
end
% ****************************************
function c = cores (tab)
% ========== Generation of color map ==========
% ========== Initialization of color table ==========
c = [];
sty = [];
% ========== Detection of relations and filling the table
    for f = 1:size(tab,1)
        cor = tab(f);
        c = [c; cor];
    end
end
% ****************************************
function pcoord = pcoord(vorder)
% The function pcoord receives a porder number and returns three
% coordinates correspondet to the position of its vector in the vecspace.
% The coordinates are calculated through the application of weight rules to
% the primary and secondare prosodic functions, giving to each vector a
% exclusive position.
% Usage:
%   pcoord(porder number of a rhythmic profile)
% Example:
% pcoord(54)
%   ans =
%       3     1     4
% 
% Created in November 2024 under MATLAB 2023 (Mac OS)
% Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright © 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ========== Initialization
load('vecdata.mat','vecdata')
names = vecdata.vstrings;
tab = [];
% ========== calculus
    for f = 1 : size(vorder,1)
        tempord = vorder(f);
    vtemp = names(tempord,:);
    AR = str2num(vtemp(2))*3+str2num(vtemp(6));
    DP = str2num(vtemp(3))*3+str2num(vtemp(7));
    AC = str2num(vtemp(4))*3+str2num(vtemp(8));
    inds = [AR,DP,AC];
    tab = [tab;inds];
    end 
pcoord = tab;
end