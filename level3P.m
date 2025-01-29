function prels = prels(profiles, relations)
eval(profiles);
eval(relaions);
% ========== Reads tables
profdata = proftab(profiles);
reldata = reltab(relations);
% ========== Profiles from level 1 to 3
perfs = [find(profdata.level<=3)]; % Perfis ate nivel 3
% =========== Profiles with P relations
inds = find(contains(reldata.rel, 'P'));
lines = [reldata.p1n(inds) reldata.p2n(inds)];
prels = [];
    for f = 1:size(lines,1)
        templine = lines(f,:);
        search = ismember(perfs, templine);
        if sum(search) == 2
            prels = [prels; templine];
        end
    end
rels = reldata(inds,:);