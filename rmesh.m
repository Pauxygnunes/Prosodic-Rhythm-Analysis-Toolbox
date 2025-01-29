function rmesh = rmesh(filename,varargin)
% The function rmesh is designed to provide partial or global rhythmeshes
% from analysis of musical pieces. It accomplishes this by plotting graphs
% and subgraphs that showcase the rhythmic profiles and their connections.
% The function reads the file 'filename', where the profiles are declared.
% There are additional arguments: 's' set the display of a rhythmic space;
% 'circle' set the circle graph style; '3D' displays the graph in three
% dimensions; 'label' forces labeling in populated graphs. The default
% settings are the surface rhythmesh and 2D display.
%
% Created in December 2023 under MATLAB 2022 (Mac OS)
%
% Â© Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright Â©2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ========== Importing variables
load('profdata.mat', 'profdata');
load('reldata.mat', 'reldata');
% ========== 3. Extracton of variables and vectors
card = profdata.fcardTH; % cardinalities
names = profdata.prof; % profile names
estratos = profdata.stratum; % strata
familias = profdata.family; % families
niveis = profdata.level; % levels
s = reldata.p1n; % porder of start profiles
t = reldata.p2n; % porder of target profiles
rels = reldata.rel; % relations between s and t profiles.
vetores = profdata.vector; % vetores
weights = ones(1,size(t,1))'; % weights flattened to one
% ========== Load options for subgraphs
% Load the list of profiles contained in the script proflist.m.
eval(filename);
perfs = unique(perfs);
refprofs = perfs;
% ========== mount the rhythmesh structure.
G = graph(s,t, weights, names);
% ========== create rhythmic space
if sum(contains(varargin, 'space'))==1
    disp ' '
    disp 'plotting rhythmic space'
    disp ' '
    perfs = profnet(G,perfs);
    originals = find(ismember(perfs, refprofs));
    news = find(~ismember(perfs, refprofs));
else
    disp ' '
    disp 'plotting surface rhythmesh'
    disp ' '
    originals = find(ismember(perfs, refprofs));
    news = find(~ismember(perfs, refprofs));
end
% ==========
% ========== Subgraph data rendering
H = subgraph(G, perfs); % mount the partial rhythmesh structure.
% ========== Extraction of relations for subgraph
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
        ind = ismember(Rst, temprel, 'rows');
        rels = [rels; reldata(ind,3)];
    end
    if size(rels) > 0
        rels = table2array(rels);
        indsty = cores(rels);
    else
        indsty = 1;
    end
% ========== Subgraph colors
styles = [{'--'}; {':'}; {'-.'}; {'-'}; {'-'}];
colors = [  .24 .45 .72;...
            .81 .1 0;...
            .16 .69 .36;...
            .79 .38 0;...
            0 0 0];
% ========== Subgraph plotting - Layout 3D
    if sum(contains(varargin, '3D'))==1
        figure('Renderer','Painters');
        GH = plot(H,...
                    'NodeColor','b',...
                    'EdgeColor', colors(indsty,:),...
                    'LineStyle', styles(indsty,:),...
                    'Layout','force3',...
                    'UseGravity', true,...
                    'LineWidth', 1.5);
        axis equal
        if ~isempty(originals)
            highlight(GH,originals, 'Marker', 'o',...
                                    'NodeColor','k',...
                                    'Markersize', 5)
        end
        if sum(contains(varargin, 'clean'))==0
            newsnames = table2array(H.Nodes(news,:));
            td = .2;    
            text(GH.XData(news)+td,...
                 GH.YData(news)+td,...
                 GH.ZData(news)+td,...
                 newsnames,...
                 'HorizontalAlignment', 'left',...
                 'VerticalAlignment', 'middle',...
                 'Color', 'k',...
                 'FontSize', 10,...
                 'FontName', 'Consolas',...
                 'Margin', 0.05)
            orignames = table2array(H.Nodes(originals,:));
            text(GH.XData(originals)+td,...
                 GH.YData(originals)+td,...
                 GH.ZData(originals)+td,...
                 orignames,...
                'HorizontalAlignment', 'left',...
                'VerticalAlignment', 'middle',...
                'Color', 'k',...
                'FontSize', 10,...
                'FontName', 'Consolas',...
                'Margin', 0.05)
        end
        GH.NodeLabel = {};
    elseif sum(contains(varargin, 'circle'))==1
        % ========== 10.1.2. Layout circle
        GH = plot(H,...
                    'EdgeColor', colors(indsty,:),...
                    'LineStyle', styles(indsty,:),...
                    'Layout','circle',...
                    'LineWidth', 1.5);
        axis equal
    elseif sum(contains(varargin, 'sub'))==1
        % ========== Layout subspace
        GH = plot(H,...
                    'EdgeColor', colors(indsty,:),...
                    'LineStyle', styles(indsty,:),...
                    'NodeColor', 'k',...
                    'Markersize', 3,...
                    'LineWidth', 1.5,...
                    'Layout', 'subspace',...
                    'Dimension', 11);
        axis equal
        newsnames = table2array(H.Nodes(news,:));
        td = .2;    
        text(GH.XData(news)+td,...
             GH.YData(news)+td,...
             GH.ZData(news)+td,...
             newsnames,...
             'HorizontalAlignment', 'left',...
             'VerticalAlignment', 'middle',...
             'Color', 'k',...
             'FontSize', 10,...
             'FontName', 'Consolas',...
             'Margin', 0.05)
        orignames = table2array(H.Nodes(originals,:));
        text(GH.XData(originals)+td,...
             GH.YData(originals)+td,...
             GH.ZData(originals)+td,...
             orignames,...
            'HorizontalAlignment', 'left',...
            'VerticalAlignment', 'middle',...
            'Color', 'k',...
            'FontSize', 10,...
            'FontName', 'Consolas',...
            'Margin', 0.05)
    else
        % ========== Subgraph plotting - Layout force
        figure('Renderer','Painters');
        GH = plot(H,...
                    'EdgeColor', colors(indsty,:),...
                    'LineStyle', styles(indsty,:),...
                    'NodeColor', 'b',...
                    'Markersize', 3,...
                    'Layout','force',...
                    'UseGravity', true,...
                    'LineWidth', 2);
        axis equal
        if originals
            highlight(GH,originals, 'Marker', 'o',...
                                    'NodeColor','k',...
                                    'Markersize', 5)
        end
        td = .1;
        if ~isempty(news)
            if sum(contains(varargin, 'clean'))==0
                newsnames = table2array(H.Nodes(news,:));
                text(GH.XData(news)+td,...
                     GH.YData(news)+td,...
                     newsnames,...
                    'HorizontalAlignment', 'left',...
                    'VerticalAlignment', 'middle',...
                    'Color', 'k',...
                    'FontSize', 10,...
                    'FontName', 'Consolas',...
                    'Margin', 0.05)
            end
        end
        if ~isempty(originals)
            if sum(contains(varargin, 'clean'))==0
                orignames = table2array(H.Nodes(originals,:));
                text(GH.XData(originals)+td,...
                     GH.YData(originals)+td, ...
                     orignames,...
                     'HorizontalAlignment', 'left',...
                     'VerticalAlignment', 'middle',...
                     'Color', 'k',...
                     'FontSize', 10,...
                     'FontName', 'Consolas',...
                     'Margin', 0.05)
            end
        end
        GH.NodeLabel = {};
    end
end
% % ========== Relation colors 
function c = cores (tab)
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
% ========== Generation of profiles space
function net = profnet(graph, perfs)
% produz pares entre todos os perfis
st = nchoosek(perfs,2);
% Montagem da rede
net = [];
for f = 1:size(st,1)
    % seleciona a linha
    templine = st(f,:);
    % capta os perfis intermediários entre cada par
    tempath = paths (graph, templine(1), templine(2));
    tempath = unique(tempath);
    if size(tempath,1)>1
        tempath = tempath';
    end
    net = [unique(net) tempath];
end
net = unique(net);
end
% ========== 
function paths = paths(G,p1,p2)
tab = [];
    for f = 1:8
        % testa se f é ímpar
        if  mod(f,2)
            tab1 = nextn(G,p1);
            sizetab1 = size(tab1,1);
            p1 = tab1;
        % testa se f é par
        else
            tab2 = nextn(G,p2);
            sizetab2 = size(tab2,1);
            p2 = tab2;
        end
% ========== Combina os pares para encontrar idênticos
        for g = 1:size(p1,1)
            temp1 = p1(g,end);
            for h = 1:size(p2,1)
                temp2 = p2(h,end);
                if temp1 == temp2
                    lintemp = [p1(g,:) fliplr(p2(h,:))];
                    lintemp = lintemp';
                    lintemp = unique(lintemp,'rows', 'stable');
                    lintemp = lintemp';
                    tab = [tab; lintemp];
                end
            end
        end
        if any(tab)
            break
        end
    end
% Utilizar essa linha para produzir a função paths independente
paths1 = filterdupl(tab);
paths = filterseq(G, paths1);
end
% ==========
function filterdupl = filterdupl(mat)
doomed = [];
    for f = 1:size(mat,1)
        templine = mat(f,:);
        templine = diff(sort(templine));
        if any(templine==0)
            doomed = [doomed, f];
        end
    end
mat(doomed,:) = [];
filterdupl = mat;
end
% ==========
function nextn = nextn(G, tab)
biglist = [];
    for g = 1:size(tab,1)
        templine = tab(g,:);
        newcols = neighbors(G,templine(end));
        [x, y] = ndgrid(newcols, templine);
        newlist = [y x(:,1)];
        biglist = [biglist;newlist];
    end
nextn = biglist;
end
% ==========
function mat = filterseq(G,mat)
testseq = [];
    for f = 1:size(mat,1)
        seq = [];
        tline = mat(f,:);
        for f = 2:size(tline,2)
            pair = [tline(1) tline(f)];
            dist = distances (G,tline(1),tline(f));
            seq = [seq, dist];
        end
        if seq == 1:size(seq,2)
            test = 1;
        else
            test = 0;
        end
    testseq = [testseq; test];
    end
indtemp = testseq == 0;
mat(indtemp,:) = [];
end
% ==========

