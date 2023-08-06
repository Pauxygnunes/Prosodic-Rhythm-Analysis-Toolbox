function suffixes = suffix (code1, code2)
% The "suffix" function serves the purpose of determining the relationship
% between pcodes or profiles, particularly whether it qualifies as a
% suffixation or not. When a suffixation is identified, the function
% returns a string that indicates its quality. In cases where no
% suffixation exists, the function returns an empty string.
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
        suffixes = [suffixes; suffix];
    end
end