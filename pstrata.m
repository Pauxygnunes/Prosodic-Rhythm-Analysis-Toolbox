function pstrata = pstrata(pcode)
% The function "pstrata" returns the strata of a rhythmic profile from its
% pcode or name. The result is a number indicating the level of the
% profile - in the rhythmesh, there are five strata of complexity.
%
% Usage:
%       pstrata (rhythmic profile code or name)
% 
% Example:
% 
%         pstrata('bt1')
%         
%         ans =
%         
%              5
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
pstrata = [];
perfs = profiles(pcode);
    for f = 1:size(pcode,1)
        tempcode = perfs{f};
        numletters = numel(find(isletter(tempcode)));
        card = size(tempcode,2);
        switch card
            case 1
                strata = 1;
            case 2
                switch numletters
                    case 0
                        strata = 2;
                    case 1
                        strata = 3;
                end
            case 3
                switch numletters
                    case 0
                        strata = 3;
                    case 1
                        strata = 4;
                    case 2
                        strata = 5;
                end
        end
        pstrata(f) = strata;
    end
    pstrata = pstrata';
end