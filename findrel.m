function findrel = findrel(code1,code2)
% The function "findrel" returns an table with five columns that shows all
% the adjacency relations between two sets of given rhythmic profiles. Each
% line of the array contains the number of order (porder) of the first and
% second profile, the adjacency relation between the pair, and the names of
% the two profiles. The sets can be declared as pcodes(numbers) or as a
% list of profiles (in the last case, the profiles must be separated by a
% semicolon). This function is useful for rendering the reltab matrix, with
% all relations in the rhythmesh, through code findrel(pcodes(1:296),
% pcodes(1:296)).
%
% Usage:
%       findrel (first set of rhythmic profiles, by code or name, second
%       set of rhythmic profiles, by code or name)
% 
% Example:
%         findrel(['001';'010'],['00T';'100'])
%         
%         ans =
%         
%           3×5 table
%         
%             p1n    p2n      rel        p1         p2   
%             ___    ___    _______    _______    _______
%         
%             28      4     {'Ptt'}    {'001'}    {'00T'}
%              4      6     {'R'  }    {'001'}    {'100'}
%              5      6     {'R'  }    {'010'}    {'100'}
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
% table montage
findrel = [];
    for f = 1:size(code1,1)
        for g = 1:size(code2,1)
        rel =   [   prolation(code1(f,:),code2(g,:))...
                    prefix(code1(f,:),code2(g,:))...
                    suffix(code1(f,:),code2(g,:))...
                    rotation(code1(f,:),code2(g,:))];
                if rel == '0'
                elseif isempty(rel)
                else
                    rel(rel=='0') = [];
                    findrel = [ findrel;...
                                rel,...
                                sort([code2p(code1(f,:)),...
                                code2p(code2(g,:))])];
                end
        end
    end
    if isempty(findrel)
        findrel = [];
    end
[~,idx] = unique(strcat(findrel(:,1),findrel(:,2),findrel(:,3)));
findrel = findrel(idx,:);
findrel = [porder(findrel(:,2)), porder(findrel(:,3)), string(findrel)];
findrel = cellstr(findrel);
sortfindrel = [];
    for f  = 1:size(findrel,1);
        templine = findrel(f,:);
        newline = [sort([templine(1) templine(2)]) templine(3:5)];
        sortfindrel = [sortfindrel; newline];
    end
findrel = sortrows(sortfindrel,1)
pstart = findrel(:,1);
p2n = findrel(:,2);
p1n = cellfun(@str2num,pstart);
p2n = cellfun(@str2num,p2n);
rel = findrel(:,3);
tempfr = [p1n p2n];
tempfr = sort(tempfr,2);
p1n = tempfr(:,1);
p2n = tempfr(:,2);
p1 = code2p(pcodes(p1n));
p2 = code2p(pcodes(p2n));
findrel = table(p1n, p2n, rel, p1, p2);
findrel = sortrows(findrel,1);
end