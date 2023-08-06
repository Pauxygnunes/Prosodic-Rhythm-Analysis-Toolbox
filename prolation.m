function prolations = prolation (code1,code2)
% The "prolation" function is designed to determine the relationship
% between pcodes or profiles, specifically whether it constitutes a prolation
% or not. When a prolation is detected, the function returns a string that
% indicates the quality of the prolation. In cases where no prolation
% relation exists, the function returns an empty string.
% 
% Usage:
%       prolation (first rhythmic profile code or name, second rhythmic profile
%       code or name)
% Example:
%         prolation ('0t1', 'tt1')
% 
%         ans =
% 
%             'Ptd'
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
% prolation analysis
prolations = [];
prolation = [];
matriz = 'tadc';
pfxrel = ['ai';'bt'];
    for f = 1:size(code1,1)
        tcode1 = (code1(f,:));
        tcode2 = (code2(f,:));
        z1 = find(tcode1 == '0');
        z2 = find(tcode2 == '0');
        z1z2 = [numel(z1) numel(z2)];
        dif = find((tcode1 == tcode2)==0);
        % ParcimÃ´nia
        if numel(dif)==1
            difs = sort([tcode1(dif) tcode2(dif)]);
            sub = sum(isletter(difs));
            if sub == 1;
                if difs(1) == '0'
                elseif any(ismember(difs,'i'))|any(ismember(difs,'t'))
                    if max(z1z2) < 3
                        prolation = ['P' lower(difs(2)) matriz(dif)];
                    end
                end
            elseif sub == 0
                if any(ismember(z1z2,3))
                    if code1(dif-1) == '1'
                        prolation = 'Pt';
                    elseif code1(dif-1) == '0'
                        prolation = 'Pi';
                    else
                        prolation = '0';
                    end
                end
            end
        end
        prolations = [prolations; prolation];
    end
end