function pnrocha = pnrocha(perf)
% The function pnrocha returns, from the profile name or its pcode, a
% ternary vector that indicates the base cardinality, the order number
% within the base cardinality, and the order number of the vector within
% the base cardinality. 
% Usage:
%   pnrocha(profile name or pcode)
% Example:
% pnrocha('tt1')
%   ans =
%       '3-1-14'
% 
% Created in November 2024 under MATLAB 2023 (Mac OS)
% Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright © 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
% Basic conversion (prof, pcode)
if size(perf,2) < 4
    perf = p2code(perf);
end
nperf = porder(perf);
classes = pclass(pcodes(1:296));
sizes = cell2mat(cellfun(@size,classes,'UniformOutput',false));
classsize = sizes(:,2);
blocks = [1 (find(abs(diff(classsize)))+1)' 297];
tab = [];
for f = 1:size(blocks,2)-1
    tempblock = (blocks(f):blocks(f+1)-1)';
    tempfamily = cell2mat(pfamily(pcodes(tempblock)));
    [~, ~, c] = unique(tempfamily);
    tab = [tab; c];
end
tab1 = strcat(num2str(classsize), '-', num2str(tab));
patterns1 = '000';
patterns2 = ['000'; '001'; '011'; '100'; '101'; '110'];
patterns3 = ['000'; '001'; '002'; '011'; '012'; '022';...
            '100'; '101'; '102'; '110'; '111'; '112';...
            '121'; '200'; '201'; '202'; '210'; '211'; '220'];
plist = pcodes(1:296);
tab = [];
    for f = 1:size(plist,1)
        temprof = plist(f,:);
        vector = pvector(temprof);
        vseg2 = vector(6:8);
        % Produz o terceiro índice
        switch classsize(f)
            case 1
                ind3 = find(ismember(patterns1, vseg2, 'rows'));
            case 2
                ind3 = find(ismember(patterns2, vseg2, 'rows'));
            case 3
                ind3 = find(ismember(patterns3, vseg2, 'rows'));
        end
        % Reune os índices
        tab = [tab; ind3;];
    end
pn = strcat(tab1, '-', num2str(tab));
pn(pn == ' ')= '0';
pnrocha = pn(nperf,:);
