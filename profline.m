function profline = profline(prof, rels)
% The profline function processes a starting rhythmic profile through a
% sequence of operations, returning the resulting profiles. Both the
% profile and operation sequence must be strings, and the output is a cell
% array. The function have two modes. In the generic mode, the operations
% are considered by its basic description: prolation(p), prefixation(f),
% suffixation(s), and rotation(r). In the specific mode, there are 25
% categories of operations, including the type and location. For example,
% FLa, Pic, SLt (see reference manual). 
% Usage:
%   profline(starting profile, sequence of relations)
% Examples:
% 
%   profline 00T spf
% 
%   mode =
%         'generic'
%   ans =
% 
%       4×2 table
% 
%        profs     dist
%       _______    ____
% 
%       {'0aD'}     3  
%       {'0bD'}     3  
%       {'a0D'}     3  
%       {'b0D'}     3
% 
%   profline 00T PicFLt
% 
%   mode =
% 
%       'specific'
% 
%   ans =
% 
%       1×2 table
% 
%        profs     dist
%       _______    ____
% 
%       {'0iB'}     2  
% 
% Created in November 2024 under Matlab R2023a (Mac OS)
% Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ......... Initialization
% ......... Set mode (find generic or specific strings)
    if sum(ismember(rels, ['L','a','c','d','t','i']))>=1
        rels = (relseg (rels));
        mode = 'specific'
        profline = specific(prof, rels);
    else
        mode = 'generic'
        profline = generic(prof, rels);
    end
end
% ***************************************
function generic = generic(prof, rels)
% ......... results by each character of rels (generic mode)
temprof = prof;
    for f = 1:size(rels,2)
        temprel = rels(f);
        temprof = props(temprof,temprel);
        if size(temprof,1) > 0
            indzero = temprof==0;
            temprof(indzero) = [];
            temprof = mat2p(temprof);
        else
            temprof = {};
        end
    end
temprof = unique(temprof);
    if isempty(temprof)
        profline = '0';
    else
        profline = makertab(prof, temprof);
    end
generic = profline;
end
% ***************************************
function specific = specific(prof, rels)
% ......... results by chunks of rels (specific mode)
temprof = prof;
    for f = 1:size(rels,2)
        temprel = rels{f};
        temprof = props(temprof,temprel);
        if size(temprof,1) > 0
            indzero = temprof==0;
            temprof(indzero) = [];
            temprof = mat2p(temprof);
        else
            temprof = '0';
        end
    end
temprof = unique(temprof);
    if isempty(temprof)
        profline = '0';
    else
        profline = makertab(prof, temprof);
    end
specific = profline;
end
% ***************************************
function props = props(prof, rel)
% The function props make the calculation and assemblage of each generation
% of profiles, applying the functions selnb and selprofs to the list of
% profiles.
load ('reldata.mat','reldata')
profs = [];
    for g = 1:size(prof,1)
        temprof = prof(g,:);
        if isempty(temprof)
            temprops = '0';
        else
            [proford, profnb] = selnb(temprof, reldata);
            temprops = selprofs(proford, profnb, rel);
            profs = [profs; temprops];
        end
    end
props = profs;
end
% ***************************************
function [proford, profnb] = selnb(prof,reldata)
% The function selnb selects the neighbors of the starting profile or
% target profile of the selnb list.
    if iscell(prof)
        prof = cell2mat(prof);
    end
    if prof == '0'
    proford = '0';
    profnb = '0';
    else
    proford = porder(prof);
    profinds1 = find(reldata.p1n == proford);
    profinds2 = find(reldata.p2n == proford);
    profinds = sort([profinds1; profinds2]);
    proflist = [reldata.p1n(profinds), reldata.p2n(profinds)];
    profnb = unique(proflist);
    profnb(profnb == proford) = [];
    end
end
% ***************************************
function selprofs = selprofs(proford, profnb, rel)
% The function selprofs test the pairs p1-p2 of each row of neighbors to
% check if they match with the correspondent relation.
results = [];
    for f = 1:size(proford,1)
        for f = 1:size(profnb,1)
            p1 = cell2mat(mat2p(proford));
            p2 = cell2mat(mat2p(profnb(f)));
            test = qrel(p1,p2);
                if contains (test, rel, 'IgnoreCase',true)
                    results = [results; profnb(f)];
                end
        end
        
    end
    if isempty(results)
        results = 0;
    end
selprofs = results;
end
% ***************************************
function makertab = makertab(prof, profs)
load('profdata.mat', 'profdata');
load('reldata.mat', 'reldata');
    if prof == '0'
        makertab = '0';
    else
        % ......... Extracton of variables and vectors
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
        % ......... Load options for subgraphs
        % Load the list of profiles contained in the script proflist.m.
        eval('simpleprofs');
        refprofs = perfs;
        % ......... Mount the rhythmesh structure.
        G = graph(s,t, weights, names);
        dist = distances(G, prof, profs);
        dist = dist';
        makertab = table(profs, dist);
    end
end
% ***************************************
function relseg = relseg(rels)
% Returns chunks of operations (specific mode)
% .......... Find beginning of operations
inds = find(ismember(rels, ['F' 'f' 'P' 'p' 'R' 'r' 'S' 's']));
    if inds
        % .......... Add the final point
        inds = [inds size(rels,2)+1];
        % .......... Set the intervals
        ints = [diff(inds)];
        % .......... Split the string into cells
        relseg = mat2cell(rels, 1, ints);
    else
        relseg = {'0'};
    end
end