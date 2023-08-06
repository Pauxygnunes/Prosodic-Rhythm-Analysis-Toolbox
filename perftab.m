function perftab = perftab(pcode)
% perftab function provides, from a list of pcodes, a table with
% correspondent prosodic rhythmic profiles, and its metainformation.
% 
% Usage
% 
% perftab(pcodes([number of pcodes]))
% 
% Example
%       tab = perftab (pcodes([1 50 100 150]))
% 
% tab =
% 
%   4×9 table
% 
%     norder     profs      class     family    level    card
%     ______    _______    _______    ______    _____    ____
% 
%        1      {'1'  }    {'n'  }    {'N'}       1       1  
%       50      {'01b'}    {'nns'}    {'B'}       4       5  
%      100      {'0bA'}    {'nss'}    {'A'}       5       7  
%      150      {'0Ib'}    {'nss'}    {'B'}       5       6  
% 
%       strata     vectors     pcode
%       ______    _________    _____
% 
%       1       [000|000]    1000 
%       4       [101|101]    1b01 
%       5       [011|112]    a01b 
%       5       [101|102]    ib01 

% 
% Created in May 2023 under MATLAB 2022 (Mac OS)
%
% � Part of Prosodic Rhythms Toolbox - PR Toolbox,
% Copyright© 2023, Pauxy Gentil Nunes Filho and Filipe Rocha
% PPGM-UFRJ
% See License.txt
% 
% ==========
% Assignment of metainformation
norder = porder(pcode);
profs = code2p(pcode);
class = pclass(pcode);
family = pfamily(pcode);
level = plevel(pcode);
card = pcard(pcode);
strata = pstrata(pcode);
vectors = pvector(pcode);
% ==========
% Assemblage of table
perftab = table(norder,...
    profs, class, family,...
    level, card, strata,...
    vectors, pcode);
end
