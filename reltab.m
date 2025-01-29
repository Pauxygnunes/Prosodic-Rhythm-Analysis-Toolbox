function rels = reltab(code1,code2)
% The function "reltab" returns an table with five columns that shows all
% the adjacency relations between two sets of given rhythmic profiles. Each
% line of the array contains the number of order (porder) of the first and
% second profile, the adjacency relation between the pair, and the names of
% the two profiles. The sets can be declared as pcodes(numbers) or as a
% list of profiles (in the last case, the profiles must be separated by a
% semicolon). This function is useful for rendering the reltab matrix, with
% all relations in the rhythmesh, through code reltab(pcodes(1:296),
% pcodes(1:296)).
%
% Usage:
%       reltab (first set of rhythmic profiles, by code or name, second
%       set of rhythmic profiles, by code or name)
% 
% Example:
%         reltab(['001';'010'],['00T';'100'])
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
rels = [];
    for f = 1:size(code1,1)
        for g = 1:size(code2,1)
            rel = qrel(code1(f,:), code2(g,:));
            if rel == '0'
            else
                rel(rel=='0') = [];
                p1 = code2p(code1(f,:));
                p2 = code2p(code2(g,:));
                ppair = sort([p1 p2]);
                rels = [rels; rel ppair(1) ppair(2)];
            end
        end
    end
    if isempty(rels)
        rels = [];
    end
[~,idx] = unique(strcat(rels(:,1),rels(:,2),rels(:,3)));
rels = rels(idx,:);
rels = [porder(rels(:,2)), porder(rels(:,3)), string(rels)];
rels = cellstr(rels);
sortfindrel = [];
    for f  = 1:size(rels,1)
        templine = rels(f,:);
        newline = [sort([templine(1) templine(2)]) templine(3:5)];
        sortfindrel = [sortfindrel; newline];
    end
rels = sortrows(sortfindrel,1);
pstart = rels(:,1);
p2n = rels(:,2);
p1n = cellfun(@str2num,pstart);
p2n = cellfun(@str2num,p2n);
rel = rels(:,3);
tempfr = [p1n p2n];
tempfr = sort(tempfr,2);
p1n = tempfr(:,1);
p2n = tempfr(:,2);
p1 = code2p(pcodes(p1n));
p2 = code2p(pcodes(p2n));
rels = table(p1n, p2n, rel, p1, p2);
rels = sortrows(rels,1);
end
