function pnvector = pnvector(pcode)
% The function pnvector provides, from the name or pcode of a rhythmic
% profile, the order number of its vector, in a range from 1 to 70.
% Usage:
%   pnvector(profile name or pcode)
% Example:
%   pnvector('10tt')
%       ans =
%           21
% 

% ========== Conversion of profile of pcode
if size(pcode,2) < 4
    pcode = p2code(pcode);
end
vlist = sortrows(pvector(pcodes(1:296)));
vlist = unique(vlist,'rows');
plist = pcode;
tab = [];
    for f = 1:size(plist,1)
        temprof = plist(f,:);
        tempvec = pvector(temprof);
        indtemp = find(ismember(vlist,tempvec, 'rows'));
        tab = [tab; indtemp];
    end
pnvector = tab;
end