function pclass = pclass(pcode)
% The function "pclass" returns the class of a rhythmic profile from its
% pcode or name. The result is a string indicating the quality of its
% elements - if they are notes or subgroups.
%
% Usage:
%       pclass(rhythmic profile code or name)
% Example:
%         pclass('10td')
%         
%         ans =
%         
%           1×1 cell array
%         
%             {'ssn'}
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
pclass = {};
profs = profiles(pcode);
    for f = 1:size(pcode,1)
        tempcode = profs{f};
        for g = 1:size(tempcode,2)
            if isletter(tempcode(g))
                tempclass(g) = 's';
            else
                tempclass(g) = 'n';
            end
        end
        pclass{f} = tempclass;
        tempclass = '';
    end
pclass = pclass';
end
