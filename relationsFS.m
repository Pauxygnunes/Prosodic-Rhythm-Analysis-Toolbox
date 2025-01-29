% ========== Initialize table of relations
load('reldata.mat','reldata');
% ========== Render clusters based on rotations
inds = find(contains (reldata.rel, {'F', 'S'}));
% ========== Select correspondet profiles
rels = reldata(inds,:);