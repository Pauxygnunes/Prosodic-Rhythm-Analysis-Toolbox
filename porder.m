function porderlist = porder(pcode)
% The function "porder" returns the number of order of a rhythmic profile
% from its pcode or name. The result is a number indicating the position of
% the profile on the pcodes list
% 
% Usage:
%       porder (rhythmic profile code or name)
% 
% Example:
% 
%         porder('bt1')
%         
%         ans =
%         
%            138
% 
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% © Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright ©2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
% basic conversion
if size(pcode,2) < 4
    code = p2code(pcode);
else
    code = pcode;
end
% ==========
% load profiles table codes
pcodefull = pcodes(1:296);
% =========
% Generate order numbers
porderlist = [];
for f = 1:size(code)
    tempcode = code(f,:);
    porder = find(ismember(pcodefull, tempcode, 'rows'));
    porderlist = [porderlist; porder];
end
end