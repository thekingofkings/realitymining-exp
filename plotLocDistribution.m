function [ locs ] = plotLocDistribution( ua, ub, records, figtitle, freq )
% plot the freq of user a and b at locations

ra = records(records(:,1) == ua, :);
rb = records(records(:,1) == ub, :);

rec_all = [ra; rb];
% size(unique(rec_all(:,3)), 1) is the number of records
unique_locs = unique(rec_all(:,3));
locs = zeros( size(unique_locs, 1),    2);

for i = 1:size(unique_locs,1)
    loc = unique_locs(i);
    loc_id = unique_locs==loc;
    % calculate user a visiting loc freq
    locs(loc_id,1) = sum(ra(:,3)==loc);
    % calculate user b visiting loc freq
    locs(loc_id,2) = sum(rb(:,3)==loc);
end

% plot

figure();
plot(locs)
legend({num2str(ua), num2str(ub)});
title([figtitle, num2str(freq)]);

end

