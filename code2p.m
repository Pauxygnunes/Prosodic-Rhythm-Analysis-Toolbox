function ncode = code2p(code)
% The function "code2p" is designed to convert a rhythmic profile code into
% its corresponding rhythmic profile name. The rhythmic profile code is
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
%       code2p(rhythmic profile code)
% Example:
%       code2p('10td')
% ans = 'td1'
%
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright © 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
ncode = [];
    for f = 1:size(code,1)
        tempcode = char(code(f,:));
        letracap = find(tempcode == '0');
        ncode{f} = monta(tempcode,letracap(end));
    end
    ncode = ncode';
end

function monta = monta(perfil,n)
monta = [];
pos = circshift((1:4),-n);
perfil(1) = upper(perfil(1));
perfil(find(perfil(2:end)=='1')+1)='x';
    for f = 1:size(perfil,2)
        if perfil(pos(f)) == '0'
        else
            monta = [monta perfil(pos(f))];
        end
    end
    monta(monta=='x')='0';
end