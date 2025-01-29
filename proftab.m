function proftab = proftab(pcode)
% The function perftab function provides, from a list of pcodes, a table
% with correspondent prosodic rhythmic profiles, and its metainformation.
% 
% Usage
% 
% proftab(pcodes([porder numbers]))
% 
% Example
%       tab = proftab (pcodes([1 50 100 150]))
% 
% tab =
% 
%   4×11 table
% 
%     norder    prof     class    card    family    level    stratum    code     vector      nvector    nrocha
%     ______    _____    _____    ____    ______    _____    _______    ____    _________    _______    ______
% 
%        1      '1'      'n'       1       'N'        1         1       1000    [000|000]       1       1-1-01
%       50      '01b'    'nns'     5       'B'        4         3       1b01    [101|101]      40       3-2-08
%      100      '0bA'    'nss'     7       'A'        5         4       a01b    [011|112]      19       3-1-12
%      150      '0Ib'    'nss'     6       'B'        5         4       ib01    [101|102]      41       3-2-09
%
% 
% Created in May 2023 under MATLAB 2022 (Mac OS)
% © Part of Prosodic Rhythms Toolbox - PR Toolbox,
% CopyrightÂ© 2023, Pauxy Gentil Nunes Filho and Filipe Rocha
% PPGM-UFRJ
% See License.txt
% 
% ==========
% Assignment of metainformation
norder = porder(pcode);
prof = code2p(pcode);
class = pclass(pcode);
bacode = pbacode(pcode);
acode = pacode(pcode);
fcardTH = pcardth(pcode);
family = pfamily(pcode);
level = plevel(pcode);
stratum = pstrata(pcode);
vector = pvector(pcode);
nvector = pnvector(pcode);
nrocha = pnrocha(pcode);
code = pcode;
% ==========
% Assemblage of table
proftab = table(norder,...
    prof, class, bacode, acode, fcardTH,...
    family,level, stratum,...
    code, vector, nvector,...
    nrocha);
end
