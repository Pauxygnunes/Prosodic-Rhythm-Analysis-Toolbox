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
% � Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright �2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
% 1. Clear screen
clc
% ==========
% 2. Importing variables
load('profiles.mat');
load('reltab.mat');
P = perfis;
R = reltab
% ==========
% 3. Extracton of variables and vectors
card = table2array(P(:,6)); % cardinalities
names = table2array(P(:,2)); % profile names
estratos = table2array(P(:,7)); % strata
familias = table2array(P(:,4)); % families
niveis = table2array(P(:,5)); % levels
s = cell2mat(R(:,1)); % porder of start profiles
t = cell2mat(R(:,2)); % porder of target profiles
rels = R(:,3); % relations between s and t profiles.
vetores = table2array(P(:,8)); % vetores
weights = ones(1,size(t,1))'; % weights flattened to one
% ==========
% 4. Graph data rendering (disabled)
% G = graph(s, t, weights, names); 
% % 
% % Graph plotting
% figure(1)
% plot(G, 'EdgeLabel', rels);
% ==========
% 5. Options for subgraphs (comment one of the following lines of create a
% custom one)
% 
% perfs = [1:296];
% perfs = [neighbors(G, 12); neighbors(G, 4)]
% perfs = [(12:16), (22:26)]; % seleciona trocaicos compostos
% perfs = [1:6]; % seleciona perfis simples
% perfs = [1:26]; % Familias I e T
% perfs = [1, 2, 4, (27:31), (42:46), (57:61)]; % Familia A ate 5 notas
% perfs = [1, 2, 3, 5, (32:36), (47:51), (62:66)]; % Familia B ate 5 notas
% perfs = [1, 3, 6, (37:41), (52:56), (67:71)]; % Familia D ate 5 notas
%  perfs = [find(niveis<=3)]; % Perfis ate nivel 3
% perfs = find(contains(familias, 'B')); % Familia B
% perfs = find(vetores == vetores(135)); % Por vetor
% perfs = find(niveis == 5); % Por níveis
% perfs = find(estratos == 6); % Por estratos
% perfs = find(card == 3); % Por cardinalidade
% perfs = [find(card==5)]; % perfis de 5 notas
% perfs = [5, 33, 8]; % Boi Preto
% ==========
% 6. Subgraph data rendering
H = subgraph(G, perfs);
% 
% 7. Extraction of relations for subgraph
F = find(ismember(s, perfs)&ismember(t, perfs));
relationsH = R(F, 3);
if size(relationsH,2) > 0
    colors = cores(relationsH);
else
    colors = [0 0 0];
end
% 
% 8. Subgraph plotting
figure (1)
% % ==========
% 9. Graph color
GH = plot(H,...
            'EdgeColor', colors,...
            'LineWidth', 1);
% GH = plot(H,'EdgeColor', colors,...
%             'LineWidth', 1);
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
% RGB Values (optional)
azul = [0 0 1];
vermelho = [1 0 0]; 
verde = [0 .5 0];
violeta = [.5 .2 .5];
% 
% Initialization of color table
c = [];
% 
% Detection of relations and filling the table
for f = 1:size(tab,1)
    relation = tab{f};
    if contains(relation, 'F')
            cor = azul;
    elseif contains(relation, 'S')
            cor = vermelho;
    elseif contains(relation, 'R')
            cor = verde;
    elseif contains(relation, 'P')
            cor = violeta;
    end
c = [c; cor];
end
% 
% output handling
c = c;
end