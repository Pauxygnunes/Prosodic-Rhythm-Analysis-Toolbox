function nperf = p2code(perf)
% The function "p2code" is designed to convert a rhythmic profile name into
% its corresponding rhythmic profile code. The rhythmic profile code is
% represented by four digits, each indicating one of the four main prosodic
% functions: Thesis, Arsis, Duplum, and Anacrusis. This code serves as a
% concise summary of the RP Matrix, making it an effective tool for
% calculating relations between different profiles. On the other hand, the
% rhythmic profile name is a representation of the rhythmic profile
% proposed by Pauxy Gentil-Nunes in his 2016 article. It consists of two or
% three characters, following the Meyer notation in time. Both the rhythmic
% profile code and name are string variables.
%
% Usage:
%       p2code(rhythmic profile name)
% Example:
%       p2code('td1')
% ans = '10td'
%
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright © 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
nperf = [];
    for f = 1:size(perf,1)
        temperf = char(perf(f,:));
        letracap = find(isstrprop(temperf,'upper'));
        numone = find(temperf=='1');
        acento = [letracap numone];
        nperf = [nperf; monta(temperf,acento)];
    end
end

function monta = monta(perfil,n)
pos = circshift((1:4),n-1);
nperf = '0000';
for f = 1:size(perfil,2)
    if isstrprop(perfil(f),'digit');
        nperf(pos(f)) = '1';
    else
        nperf(pos(f)) = perfil(f);
    end
end
nperf(pos(n)) = lower(nperf(pos(n)));
monta = nperf;
end