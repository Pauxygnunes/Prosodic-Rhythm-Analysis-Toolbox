function pacode = pacode(pcodes)
% The function "pacode" returns the profile accent code from its pcode or
% name. The result is a string indicating a sequence of accented or
% unaccented notes. This pattern is an important feature shared between
% profiles that can lead to alternative analyses.
%
% Usage:
%       pacode (rhythmic profile code or name)
% 
% Example:
% 
%         pacode('bt1')
%         
%         ans =
%         
%              '010101'
% 
% Created in June 2024 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright © 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
% Basic conversion (prof, pcode)
if size(pcodes,2) < 4
    pcodes = p2code(pcodes);
end
% Initialization
basicp = {'01', '10', '001', '010', '100'};
basicn = {'i', 't', 'a', 'b', 'd'};
basicm = {'I', 'T', 'A', 'B', 'D'};
basict = {'02', '20', '002', '020', '200'};
pacode = {};
tempacode = '';
    for f = 1:size(pcodes,1)
    % working with profile name
    tempcode = pcodes(f,:);
    temprof = char(code2p(tempcode));
    % select, convert char to basic profiles, and concatenate
        for g = 1:size(temprof,2)
            tempchar = temprof(g);
            % Read sequentially each character of profile
            switch tempchar
                case '1'
                    tempacode = [tempacode, '2'];
                case '0'
                    tempacode = [tempacode, '1'];
                otherwise
                    % In case of letter, verify the case and point to the
                    % correspondent set (basicp or basict), adding the new
                    % code
                    indn = ismember(basicn, tempchar);
                    if ~indn
                        indm = ismember(basicm, tempchar);
                        newcode = char(basict(indm));
                    else
                        newcode = char(basicp(indn));
                    end
                    tempacode = [tempacode, newcode];
            end
        end
        pacode{f} = tempacode;
        tempacode = '';
    end
pacode = pacode';    
end