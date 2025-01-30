function polygons(prof, vertices, indline)
% The polygons function explores geometric forms within the rhythmesh.
% Relationships between profiles form cycles of 3, 4, or more edges, which
% can be analyzed and used to design compositional structures. Given a
% profile and a specified number of edges, the function returns a partial
% rhythmesh containing one polygon with the specified number of vertices
% that includes the given profile. The user can select a profile name and a
% number of vertices (currently limited to 3-5). The figure has a button to
% cycle through all possible polygons.
% 
% Usage:
%   polygons(profile name, number of edges, id of polygon)
% 
% Example:
%   polygons('tb1', 3, 3)
% 
% Created in November 2024 under MATLAB 2023 (Mac OS)
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright © 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% .......... Open chronometer
tic
% ---------- Disable warnings
warning('off','all')
% ---------- Importing variables
load('profdata.mat', 'profdata');
load('reldata.mat', 'reldata');
% ---------- Extracton of variables and vectors
names = profdata.prof; % profile names
estratos = profdata.stratum; % strata
familias = profdata.family; % families
niveis = profdata.level; % levels
s = reldata.p1n; % porder of start profiles
t = reldata.p2n; % porder of target profiles
rels = reldata.rel; % relations between s and t profiles.
vetores = profdata.vector; % vetores
weights = ones(1,size(t,1))'; % weights flattened to one
% ---------- mount the rhythmesh structure.
G = graph(s,t, weights, names);
% ========== Create the graph structure
p = porder(prof);
mustBeInRange(vertices,2,6);
% ---------- Choose and draw the polygon
    for f = 1:vertices-1
        tl = tlist(G, p);
        p = tl;
    end
tl = nbfilter(tlist(G, tl));
tlp = code2p(pcodes(tl));
list = reshape (tlp, [size(tl,1), size(tl,2)]);
tabinds = (1:size(list, 1));
tabinds = circshift(tabinds, -(indline-1));
% .......... Do the calculus
plotH(G, list, tabinds, prof, reldata)
% .......... close chronometer
toc
end
% *******************************************************
function plotH = plotH(G, list, tabinds, prof, reldata)
% .......... Subgraph data rendering
profs = unique(porder(list(tabinds(1),:)'));
H = subgraph(G, profs);
% .......... Extraction of relations for subgraph
HE = H.Edges(:,1);
HE = table2array(HE);
S = HE(:,1);
T = HE(:,2);
tab = [];
    for f = 1:size(S,1)
       tab = [tab; porder(S(f)) porder(T(f))];
    end
Rst = [reldata.p1n reldata.p2n];
rels = [];
    for f = 1:size(tab,1)
        temprel = sort(tab(f,:));
        ind = find(ismember(Rst, temprel, 'rows'));
        rels = [rels; reldata.rel(ind)];
    end
    if size(rels) > 0
        indsty = cores(rels);
    else
        indsty = 1;
    end
% .......... Subgraph colors
styles = [{'--'}; {':'}; {'-.'}; {'-'}; {'-'}];
colors = [  .24 .45 .72;...
            .81 .1 0;...
            .16 .69 .36;...
            .79 .38 0;...
            0 0 0];
F.f = figure (1);
% .......... Buttons
F.rw = uicontrol('style','push',...
                 'units','pix',...
                 'position',[10 10 60 30],...
                 'fontsize',12,...
                 'string','10<<',...
                 'callback',{@rw_call,F, G, list, tabinds, prof, reldata});
F.bk = uicontrol('style','push',...
                 'units','pix',...
                 'position',[70 10 60 30],...
                 'fontsize',12,...
                 'string','1<',...
                 'callback',{@bk_call,F, G, list, tabinds, prof, reldata});
F.pb = uicontrol('style','push',...
                 'units','pix',...
                 'position',[130 10 60 30],...
                 'fontsize',12,...
                 'string','>1',...
                 'callback',{@pb_call,F, G, list, tabinds, prof, reldata});
F.fw = uicontrol('style','push',...
                 'units','pix',...
                 'position',[190 10 60 30],...
                 'fontsize',12,...
                 'string','>>10',...
                 'callback',{@fw_call,F, G, list, tabinds, prof, reldata});
% .......... Layout force
GH = plot(H,...
            'EdgeColor', colors(indsty,:),...
            'LineStyle', styles(indsty,:),...
            'Layout','force',...
            'UseGravity', true,...
            'LineWidth', 2,...
            'NodeFontSize', 12,...
            'NodeFontName', 'Courier',...
            'NodeFontWeight', 'bold');
axis equal
ind = size(list,2)-1;
    if ind > 0
        indforma = ind-2;
        formas = {  'Triangle',...
                    'Quadrilateral',...
                    'Pentagon',...
                    'Hexagon'};
        forma = formas{indforma};
    else
        forma = ' ';
    end
indline = num2str(tabinds(1));
title ([forma ' with profile (' prof '): ' indline '/',...
        num2str(size(list,1))],...
        'FontSize', 12,...
        'FontWeight','Normal')
highlight(GH,prof, 'Marker', 'o',...
                        'NodeColor','k',...
                        'Markersize', 8)
end
% *******************************************************
function c = cores (tab)
% Generation of color map
% ========== Initialization of color table
c = [];
sty = [];
% ========== Detection of relations and filling the table
    for f = 1:size(tab,1)
        relation = tab{f};
        if contains(relation, 'F')
                cor = 1;
        elseif contains(relation, 'S')
                cor = 2;
        elseif contains(relation, 'R')
                cor = 3;
        elseif contains(relation, 'P')
                cor = 4;
        else
            cor = 5;
        end
    c = [c; cor];
    end
end
% *******************************************************
function nbfilter = nbfilter(combs)
list = [];
for f = 1:size(combs,1)
    templine = combs(f,:);
    if templine(1)==templine(end)
        if size(templine,2)-size(unique(templine),2) == 1
            list = [list; templine];
        end
    end
end
nbfilter = deldupl(list);
end
% *******************************************************
function tlist = tlist(G, list)
tlist = [];
    for f = 1:size(list,1)
        templine = list(f,:);
        perfilativo = templine(end);
        nb = neighbors(G, perfilativo);
        tempcol = repmat(templine, size(nb,1), 1);
        tlist = [tlist; tempcol nb];
    end
end
%  *******************************************************
function deldupl = deldupl(list)
doomed = [];
slist = sort(list,2);
[~,b,~] = unique(slist, 'rows');
deldupl = list(b,:);
end
% *******************************************************
function pb_call(varargin)
F = varargin{3};  % Get the structure.
G = varargin{4};
list = varargin{5};
tabinds = varargin{6};
prof = varargin{7};
reldata = varargin{8};
tabinds = circshift(tabinds, -1);
plotH(G, list, tabinds, prof, reldata);
end
% *******************************************************
function bk_call(varargin)
F = varargin{3};  % Get the structure.
G = varargin{4};
list = varargin{5};
tabinds = varargin{6};
prof = varargin{7};
reldata = varargin{8};
tabinds = circshift(tabinds, 1);
plotH(G, list, tabinds, prof, reldata);
end
% *******************************************************
function rw_call(varargin)
F = varargin{3};  % Get the structure.
G = varargin{4};
list = varargin{5};
tabinds = varargin{6};
prof = varargin{7};
reldata = varargin{8};
tabinds = circshift(tabinds, 10);
plotH(G, list, tabinds, prof, reldata);
end
% *******************************************************
function fw_call(varargin)
F = varargin{3};  % Get the structure.
G = varargin{4};
list = varargin{5};
tabinds = varargin{6};
prof = varargin{7};
reldata = varargin{8};
tabinds = circshift(tabinds, -10);
plotH(G, list, tabinds, prof, reldata);
end
