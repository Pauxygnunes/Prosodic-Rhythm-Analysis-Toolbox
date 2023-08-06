function plevel = plevel(pcode)
% The function "plevel" returns the level of a rhythmic profile from its
% pcode or name. The result is a number indicating the level of the
% profile - in the rhythmesh, there are five levels of complexity.
%
% Usage:
%       plevel(rhythmic profile code or name)
% 
% Example:
%         plevel('10td')
%         
%         ans =
%         
%              5
% 
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright ©2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
if size(pcode,2) < 4
    pcode = p2code(pcode);
end
plevel = [];
    for f = 1:size(pcode,1)
        tempcode = pcode(f,:);
        notes = numel(find(tempcode=='1'));
        subs = numel(find(isletter(tempcode)));
        switch notes
            case 1
                switch subs
                    case 0
                        level = 1;
                    case 1
                        level = 3;
                    case 2
                        level = 5;
                end
            case 2
                switch subs
                    case 0
                        level = 2;
                    case 1
                        level = 4;
                end
            case 3
                        level = 3;
        end
        plevel(f) = level;
    end
    plevel = plevel';
end