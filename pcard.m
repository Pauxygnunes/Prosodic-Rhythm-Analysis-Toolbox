function pcard = pcard(pcode)
% The function "pcard" returns the cardinality of a rhythmic profile from
% its pcode or name. The result is numeric.
%
% Usage:
%       pcard(rhythmic profile code or name)
% Example:
%         pcard('td1')
%         
%         ans = 6
% 
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright © 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
if size(pcode,2) < 4
    pcode = p2code(pcode);
end
pcard = [];
    for f = 1:size(pcode, 1)
        tempcode = pcode(f,:);
        notes = numel(find(tempcode=='1'));
        binary = numel(find(tempcode=='i'|...
                            tempcode=='I'|...
                            tempcode=='t'| ...
                            tempcode=='T'));
        ternary = numel(find(tempcode=='a'|...
                            tempcode=='A'|...
                            tempcode=='b'| ...
                            tempcode=='B'|...
                            tempcode=='d'|...
                            tempcode=='D'));
        pcard(f) = notes + binary*2 + ternary*3;
    end
    pcard = pcard';
end