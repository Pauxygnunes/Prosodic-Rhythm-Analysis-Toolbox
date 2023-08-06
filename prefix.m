function prefixes = prefix(code1, code2)
% The "prefix" function serves to determine the relationship between pcodes
% or profiles, specifically whether it constitutes a prefix relation or
% not. When a prefix relation is identified, the function returns a string
% indicating the quality of the prefixation. In cases where no prefix
% relation exists, the function returns an empty string.
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
        % HÃ¡ parcimÃ´nia
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
        prefixes = [prefixes; prefix];
    end
end