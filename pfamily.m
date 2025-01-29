function pfamily = pfamily(pcode)
% The function "pfamily" returns the family of a rhythmic profile from its
% pcode or name. The result is a string indicating the quality of base
% profile - if it is iambic, trocaic, anapest, anfibrach, or dactyl.
%
% Usage:
%       pfamily(rhythmic profile code or name)
% 
% Example:
%         pclass('10td')
%         
%         ans =
%         
%           1×1 cell array
%         
%             {'A'}
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
pfamily = {};
profs = code2p(pcode);
    for f = 1:size(pcode,1)
        tempcode = profs{f};
        card = size(tempcode,2);
        saccent = find(isstrprop(tempcode,'upper'));
        naccent = find(tempcode=='1');
        taccent = [saccent naccent];
        switch card
            case 1
                family = 'N';
            case 2
                switch taccent
                    case 1
                        family = 'T';
                    case 2
                        family = 'I';
                end
            case 3
                switch taccent
                    case 1
                        family = 'D';
                    case 2
                        family = 'B';
                    case 3
                        family = 'A';
                end
        end
        pfamily{f} = family;
    end
    pfamily = pfamily';
end
