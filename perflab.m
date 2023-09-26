% The "perflab" script is designed to explore the complexity of rhythmic
% relations within the rhythmesh. It accomplishes this by plotting graphs
% and subgraphs that showcase the rhythmic profiles and their connections.
% To select the data to be plotted, you can uncomment the desired command
% in section 5 of the script or create variations based on the provided
% examples. Before running the script, ensure that the files perfis.mat and
% reltab.mat are located in the same folder as the script to ensure smooth
% execution.
%
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright ©2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
% 1. Clear screen
clc
% ==========
% 2. Importing variables
load('profiles.mat');
load('reltab.mat');
P = profiles;
R = reltab;
% ==========
% 3. Extracton of variables and vectors
card = table2array(P(:,6)); % cardinalities
names = table2array(P(:,2)); % profile names
estratos = table2array(P(:,7)); % strata
familias = table2array(P(:,4)); % families
niveis = table2array(P(:,5)); % levels
s = table2array(R(:,1)); % porder of start profiles
t = table2array(R(:,2)); % porder of target profiles
rels = R(:,3); % relations between s and t profiles.
vetores = table2array(P(:,8)); % vetores
weights = ones(1,size(t,1))'; % weights flattened to one
% ==========
% 4. Graph data rendering (disabled)
G = graph(s, t, weights, names);
% 
% Graph plotting
% figure(1)
% plot(G, 'EdgeLabel', rels);
% ==========
% 5. Options for subgraphs (comment one of the following lines of create a
% custom one)
% 
perfs = [1:296];
% perfs = unique([neighbors(G, 12); neighbors(G, 4)])
% perfs = [(12:16), (22:26)]; % seleciona trocaicos compostos
% perfs = [1:7]; % seleciona perfis simples
% perfs = [1,2,3,4,6,13,33,38,128]; % Minueto Anna Magdalena
% perfs = nearest(G,3,5);
% perfs = shortestpath(G,3,183)
% perfs = shortestpath(G, 1,128)
% perfs = [1:26]; % Familias I e T
% perfs = [1, 2, 4, (27:31), (42:46), (57:61)]; % Familia A ate 5 notas
% perfs = [1, 2, 3, 5, (32:36), (47:51), (62:66)]; % Familia B ate 5 notas
% perfs = [1, 3, 6, (37:41), (52:56), (67:71)]; % Familia D ate 5 notas
% perfs = [find(niveis<=3)]; % Perfis ate nivel 3
% perfs = find(contains(familias, 'B')); % Familia B
% perfs = find(vetores == vetores(135)); % Por vetor
% perfs = find(niveis == 5); % Por niveis
% perfs = find(estratos == 6); % Por estratos
% perfs = find(card == 3); % Por cardinalidade
% perfs = [find(card==5)]; % perfis de 5 notas
% perfs = [5, 33, 8]; % Boi Preto
% perfs = [2, 3, 5, 17, 43, 42, 45, 152, 182];
% ==========
% 6. Subgraph data rendering
H = subgraph(G, perfs);
% 
% 7. Extraction of relations for subgraph
HE = H.Edges(:,1);
HE = table2array(HE);
S = HE(:,1);
T = HE(:,2);
tab = [];
for f = 1:size(S,1)
   tab = [tab; porder(S(f)) porder(T(f))];
end
Rst = table2array(R(:,1:2));
rels = [];
for f = 1:size(tab,1)
    temprel = sort(tab(f,:));
    ind = find(ismember(Rst, temprel, 'rows'));
    rels = [rels; R(ind,3)];
end
rels = table2array(rels);
if size(rels) > 0
    indsty = cores(rels);
end
% 
% 8. Subgraph plotting
figure (1)
% % ==========
% 9. Graph color
styles = [{'--'}; {':'}; {'-.'}; {'-'}; {'-'}];
colors = [.24 .45 .72; .81 .1 0; .16 .69 .36; .79 .38 0; 0 0 0];
% ========== layout force
% GH = plot(H,...
%             'EdgeColor', colors(indsty,:),...
%             'LineStyle', styles(indsty,:),...
%             'Layout','force',...
%             'UseGravity', true,...
%             'LineWidth', 1.5);

% ========== layout circle
GH = plot(H,...
            'EdgeColor', colors(indsty,:),...
            'LineStyle', styles(indsty,:),...
            'Layout','circle',...
            'LineWidth', 1.5);
% axis equal
% % ==========
% 10. Relation names
% GH = plot(H,...
%             'EdgeLabel', relationsH,...
%             'LineWidth', 1);
% ==========
GH.NodeLabelMode = 'auto';
% 
function c = cores (tab)
% Generation of color map
% Initialization of color table
c = [];
sty = [];
% 
% Detection of relations and filling the table
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