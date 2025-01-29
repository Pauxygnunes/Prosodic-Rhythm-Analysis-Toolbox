function qrel = qrel(p1, p2)
% The qrel function returns the relation between a pair of rhythmic
% profiles. 
% Usage:
%   qrel(first profile, second profile)
% Example:
%   qrel('001', '01')
%       ans =
%           'F'
% Created in November 2024 under Matlab R2023a (Mac OS)
% Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% ========== Initialization
p = prolation(p1,p2);
f = prefix(p1,p2);
s = suffix(p1,p2);
r = rotation(p1,p2);
% ========== Testing each relation
    if p ~= '0'
        qrel = p;
    elseif f ~= '0'
        qrel = f;
    elseif s ~= '0'
        qrel = s;
    elseif r ~= '0'
        qrel = r;
    else
        qrel = '0';
    end
end
% ==========
function prefixes = prefix(code1, code2)
% The "prefix" function serves to determine the relationship between pcodes
% or profiles, specifically whether it constitutes a prefix relation or
% not. When a prefix relation is identified, the function returns a string
% indicating the quality of the prefixation. In cases where no prefix
% relation exists, the function returns a '0'string.
% 
% Usage:
%       prefix(first rhythmic profile code or name, second rhythmic profile
%       code or name)
% Example:
%         prefix('bt1', 'tt1')
% 
%         ans =
% 
%             'FLd'
% 
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright ©2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
% basic conversion
if size(code1,2) < 4
    code1 = p2code(code1);
end
if size(code2,2) < 4
    code2 = p2code(code2);
end
% prefix analysis
prefixes = [];
prefix = [];
matriz = 'tadc';
pfxrel = ['ai';'bt'];
    for f = 1:size(code1,1)
        tcode1 = (code1(f,:));
        tcode2 = (code2(f,:));
        z1 = find(tcode1 == '0');
        z2 = find(tcode2 == '0');
        z1z2 = [numel(z1) numel(z2)];
        dif = find((tcode1 == tcode2)==0);
        % detects parsimony
        if size(dif,2)==1
            difs = sort([tcode1(dif) tcode2(dif)]);
            % perfil simples
            if isletter(difs) == [0 0]
                if any(ismember(z1z2,3))
                    prefix = '0';
                elseif code1(dif-1) == '0'
                    prefix = 'F';
                end
            elseif any(ismember(pfxrel, difs, 'rows'))
                prefix = ['FL' matriz(dif)];
            else
                prefix = '0';
            end   
        end
        if isempty(prefix)
            prefix = '0';
        end
        prefixes = [prefixes; prefix];
    end
end
% ==========
function suffixes = suffix (code1, code2)
% The "suffix" function serves the purpose of determining the relationship
% between pcodes or profiles, particularly whether it qualifies as a
% suffixation or not. When a suffixation is identified, the function
% returns a string that indicates its quality. In cases where no
% suffixation exists, the function returns a '0'string.
% 
% Usage:
%       suffixation (first rhythmic profile code or name, second rhythmic
%       profile code or name)
% Example:
%         suffix ('0t1', '0d1')
% 
%         ans =
% 
%             'SLc'
% 
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright © 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
% basic conversion
if size(code1,2) < 4
    code1 = p2code(code1);
end
if size(code2,2) < 4
    code2 = p2code(code2);
end
% prefix analysis
suffixes = [];
suffix = [];
matriz = 'tadc';
pfxrel = ['bi';'dt'];
    for f = 1:size(code1,1)
        tcode1 = (code1(f,:));
        tcode2 = (code2(f,:));
        z1 = find(tcode1 == '0');
        z2 = find(tcode2 == '0');
        z1z2 = [numel(z1) numel(z2)];
        dif = find((tcode1 == tcode2)==0);
        if size(dif,2)==1
            difs = sort([tcode1(dif) tcode2(dif)]);
            % simple profile
            if isletter(difs) == [0 0]
                if any(ismember(z1z2,3))
                    suffix = '0';
                elseif code1(dif-1) == '1'
                    suffix = 'S';
                elseif isletter(code1(dif-1))
                    suffix = 'S';
                end
            elseif any(ismember(pfxrel, difs, 'rows'))
                suffix = ['SL' matriz(dif)];
            else
                suffix = '0';
            end
        end
        if isempty(suffix)
            suffix = '0';
        end
    suffixes = [suffixes; suffix];
    end
end
% ==========
function prolations = prolation (code1,code2)
% The "prolation" function is designed to determine the relationship
% between pcodes or profiles, specifically whether it constitutes a prolation
% or not. When a prolation is detected, the function returns a string that
% indicates the quality of the prolation. In cases where no prolation
% relation exists, the function returns a '0'string.
% 
% Usage:
%       prolation (first rhythmic profile code or name, second rhythmic profile
%       code or name)
% Example:
%         prolation ('0t1', 'tt1')
% 
%         ans =
% 
%             'Ptd'
% 
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright © 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
% basic conversion
if size(code1,2) < 4
    code1 = p2code(code1);
end
if size(code2,2) < 4
    code2 = p2code(code2);
end
% prolation analysis
prolations = [];
prolation = [];
matriz = 'tadc';
pfxrel = ['ai';'bt'];
    for f = 1:size(code1,1)
        tcode1 = (code1(f,:));
        tcode2 = (code2(f,:));
        z1 = find(tcode1 == '0');
        z2 = find(tcode2 == '0');
        z1z2 = [numel(z1) numel(z2)];
        dif = find((tcode1 == tcode2)==0);
        % Parsimony
        if numel(dif)==1
            difs = sort([tcode1(dif) tcode2(dif)]);
            sub = sum(isletter(difs));
            if sub == 1
                if difs(1) == '0'
                elseif any(ismember(difs,'i'))||any(ismember(difs,'t'))
                    if max(z1z2) < 3
                        prolation = ['P' lower(difs(2)) matriz(dif)];
                    end
                end
            elseif sub == 0
                if any(ismember(z1z2,3))
                    if code1(dif-1) == '1'
                        prolation = 'Pt';
                    elseif code1(dif-1) == '0'
                        prolation = 'Pi';
                    else
                        prolation = '0';
                    end
                end
            end
        end
        if isempty(prolation)
            prolation = '0';
        end
        prolations = [prolations; prolation];
    end
end
% ==========
function rotations = rotation(code1, code2)
% The "rotation" function serves the purpose of determining the
% relationship between pcodes or profiles, particularly whether it qualifies
% as a rotation or not. When a rotation is identified, the function returns
% a string that indicates its quality. In cases where no rotation exists,
% the function returns a '0'string.
% 
% Usage:
%       rotations (first rhythmic profile code or name, second rhythmic
%       profile code or name)
% Example:
%         rotation ('0t1', '0i1')
% 
%         ans =
% 
%             'RLc'
% 
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright ©2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
% basic conversion
if size(code1,2) < 4
    code1 = p2code(code1);
end
if size(code2,2) < 4
    code2 = p2code(code2);
end
% rotation analysis
rotations = [];
rot = [];
matriz = 'tadc';
pfxrel = ['it';'ab';'bd';'ad'];
    for f = 1:size(code1,1)
        tcode1 = (code1(f,:));
        tcode2 = (code2(f,:));
        %icode1 = code1(f,2:4)
        %icode2 = code2(f,2:4)
        z1 = find(tcode1 == '0');
        z2 = find(tcode2 == '0');
        z1z2 = [numel(z1) numel(z2)];
        dif = find((tcode1 == tcode2)==0);
        % there is parsimony
        if size(dif,2) > 1
            if (any((isletter(tcode1)|isletter(tcode2))))==0
            dif1 = sort(tcode1(dif));
            dif2 = sort(tcode2(dif));
            % simple profile
                if dif1 == dif2 & isequal(tcode1(1),tcode2(1))
                    rot = 'R';
                end
            end
        elseif size(dif,2)==1
            dif = find((tcode1 == tcode2)==0);
            difs = sort([tcode1(dif) tcode2(dif)]);
            if sum(isletter(difs))==2
                    if any(ismember(pfxrel,difs,'rows'))
                        rot = ['RL' matriz(dif)];
                    end
            end
        else
            rot = '0';
        end
    end
    if isempty(rot)
        rot = '0';
    end
    rotations = [rotations; rot];
end
