function mat2p = mat2p(mat)
% The function mat2p has a basic utility of conversion of porder numbers
% referent to rhythmic profiles to profiles names. The input can be only
% one number or a vertical matrix of numbers, always in the range of 1 to
% 296.
% Usage:
%   mat2p(p-order number from 1 to 296)
% Example:
%   mat2p(87)
%       ans =
%           1×1 cell array
%           {'0iT'}
% Created in November 2024 under MATLAB 2023 (Mac OS)
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright © 2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ======= Initialization and conversion
codes = pcodes(mat);
result = code2p(codes);
mat2p = reshape(result, size(mat));
end