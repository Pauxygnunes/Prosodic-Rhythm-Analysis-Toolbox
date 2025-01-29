function rellab = rellab(varargin)
% The function rellab is designed to explore the complexity of rhythmic
% relations within the rhythmesh. It accomplishes this by plotting graphs
% and subgraphs that showcase the rhythmic profiles and their connections
% based on the relations (edges). The selection is based on m files saved
% in the same folder of the function, that are used as argument to the
% function.
%
% Usage:
%   rellab(profilename, relationsfilename)
%
% Example:
%   rellab level3 relationsP
% 
% Created in July 2023 under MATLAB 2022 (Mac OS)
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright ©2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ========== Importing variables
tab = prels(varargin{1}, varargin{2});
perfs = unique([tab.p1n tab.p2n]);
tpdata = proftab(pcodes(perfs));
tpdata.norder = sortab(tpdata.norder);
% ========= Converting number of profiles, absolute to relative
perfs = sortab([tab.p1n tab.p2n]);
tab.p1n = perfs(:,1);
tab.p2n = perfs(:,2);
% ========== Extracton of variables and vectors
card = tpdata.fcardTH; % cardinalities
names = tpdata.prof; % profile names
estratos = tpdata.stratum; % strata
familias = tpdata.family; % families
niveis = tpdata.level; % levels
vetores = tpdata.vector; % vetores
% ========== Extraction of variables
s = tab.p1n;
t = tab.p2n;
weights = ones(1,size(t,1));
names = tpdata.prof;
rels = tab.rel;
G = graph(s,t,weights,names);
    if numel(varargin) == 2
        plotG(G, tab, varargin{1}, varargin{2});
    elseif sum(contains(varargin, '3D'))==1
        plotG3D(G, tab, varargin{1}, varargin{2});
    end
end
% ****************************************
function plotG = plotG(G, rels, p, r, varargin)
% The function plotG contains the information to plot the prosodic rhythm
% graph, and do the plotting itself.
%
% Usage:
%   plotG(graph, selection)
% Example:
%   plotG(G, relations)
% 
% Created in July 2023 under MATLAB 2022 (Mac OS)
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright ©2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ========== Plotting
colors = cores(rels.rel);
figure
H = plot(G,...
    'EdgeColor', colors,...
    'NodeFontSize', 12,...
    'NodeFontName', 'Menlo',...
    'Layout','force',...
    'LineWidth', 1.5);
title ([p ' | ' r]);
    if sum(contains(varargin, 'labels'))==1
        H.NodeLabelMode = 'auto';
    end
end
% ****************************************
function plotG3D = plotG3D(G, rels, p, r)
% ---------- Plotting
colors = cores(rels.rel);
figure('Renderer','Painters');
H = plot(G,...    
    'EdgeColor', colors,...
    'NodeFontSize', 12,...
    'NodeFontName', 'Menlo',...
    'Layout','force3',...
    'LineWidth', 1.5);
title ([p ' | ' r]);
end
% ****************************************
function c = cores (tab)
% ---------- RGB values and styles
styles = [{'--'}; {':'}; {'-.'}; {'-'}; {'-'}];
colors = [  .24 .45 .72;...
            .81 .1 0;...
            .16 .69 .36;...
            .79 .38 0;...
            0 0 0];
% ========== Initialize color table
c = [];
% ========== Detection of relation classes
    for f = 1:size(tab,1)
        relation = tab{f};
        if contains(relation, 'F')
                cor = colors(1,:);
        elseif contains(relation, 'S')
                cor = colors(2,:);
        elseif contains(relation, 'R')
                cor = colors(3,:);
        elseif contains(relation, 'P')
                cor = colors(4,:);
        end
    c = [c; cor];
    end
end
% ****************************************
function sortab = sortab(tab)
sorta = unique(tab);
newa = [];
    for f = 1:numel(sorta)
        inds = sorta (f) == tab;
        tab (inds) = f; 
    end
sortab = tab;
end
% ****************************************
function prels = prels(profiles, relations)
eval(profiles)
perfs = unique(perfs)';
eval(relations)
code1 = rels.p1n;
code2 = rels.p2n;
% ========== Reads tables
lines = [code1, code2];
% =========== Profiles with P relations
prels = [];
    for f = 1:size(lines,1)
        templine = lines(f,:);
        search = ismember(perfs, templine);
        if sum(search) == 2
            prels = [prels; rels(f,:)];
        end
    end
end