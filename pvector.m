function pvector = pvector(pcode)
% The function "pvector" returns the vector of prosodic functions of a
% rhythmic profile from its pcode or name. The vector indicates the
% multiplicities of each prosodic function contained in a rhythmic profile.
% Vectors aggregate profiles in substructures inside the rhythmesh. As the
% thesis (T) are always present, the vectors show the primary and secondary
% functions A, D, and C, in the form [ADC|adc].
%
% Usage:
%       pvector (rhythmic profile code or name)
% 
% Example:
% 
%         pvector ('tt1')
%         
%         ans =
%         
%             '[011|200]'
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
partes = size(pcode,2);
pvector = [];
    for f = 1:size(pcode,1)
        subvector2 = [0 0 0];
        tempcode1 = pcode(f,2:end);
        tempcode1(find(tempcode1~='0'))='1';
        tempcode2 = pcode(f,:);
        letters = tempcode2(isletter(tempcode2));
        for g = 1:size(letters,2)
            templetter = letters(g);
            switch templetter
                case 'i'
                    subvector2(3) = subvector2(3)+1;
                case 't'
                    subvector2(1) = subvector2(1)+1;
                case 'a'
                    subvector2(2) = subvector2(2)+1;
                    subvector2(3) = subvector2(3)+1;
                case 'b'
                    subvector2(1) = subvector2(1)+1;
                    subvector2(3) = subvector2(3)+1;
                case 'd'
                    subvector2(1) = subvector2(1)+1;
                    subvector2(2) = subvector2(2)+1;
            end
        end
        subvector2 = num2str(subvector2);
        subvector2(subvector2==' ') = [];
        tvector = ['[',tempcode1, '|', subvector2,']'];
        pvector = [pvector; tvector];
    end
end