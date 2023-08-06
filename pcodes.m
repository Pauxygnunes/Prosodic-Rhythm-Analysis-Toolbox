function pcodes = pcodes(n)
% The function "pcodes" returns the code of a rhythmic profile from its
% porder number. The pcodes form a fixed list and it is necessary to
% retrieve the code from its order number for some calculations and
% conversions. This function can produce the list of all rhythmic profiles,
% called "profiles.mat", through the command "pcodes(1:296)".
%
% Usage:
%       pcodes(rhythmic profile code or name)
% 
% Example:
%             pcodes(52)
%             
%             ans =
%             
%                 '110i'
% 
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright © 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========

pbase = 'itabd';
levare = '0';
acento = '1';

% Note (first strata)
tab = '1000';

% Simple grouping (second strata)
i = '1001';
t = '1100';
a = '1011';
b = '1101';
d = '1110';
simples = [i;t;a;b;d];
tab = [tab; simples];

% (third strata)
estrato3 = [];
tempblock = [];
for f = 2:size(tab,1)
    perf = tab(f,:);
    cols = find (perf=='1');
    for g = 1:numel(cols);
        for h = 1:5
            perf(cols(g)) = pbase(h);
            tempblock = [tempblock;perf];
        end
        perf = tab(f,:);
        cols = find (perf=='1');
        estrato3 = [estrato3; tempblock];
        tempblock = [];
    end
end

estrato3;

% (fourth strata)
estrato4 = [];
tempblock = [];
for f = 21:size(estrato3,1)
    perf = estrato3(f,:);
    cols = find (perf=='1');
    for g = 1:numel(cols);
        for h = 1:5
            perf(cols(g)) = pbase(h);
            pzeros = find(ismember(perf,'0'));
            if numel(pzeros)==1
                tempblock = [tempblock;perf];
            end
        end
        perf = estrato3(f,:);
        cols = find (perf=='1');
        estrato4 = [estrato4; tempblock];
        tempblock = [];
    end
end

estrato4;

tab = [tab; estrato3; estrato4];
pcodes = unique(tab,'rows','stable');
pcodes = pcodes(n,:);

end