function [ locs_f, locIDmap ] = pairLocDistribution( ua, ub, records, figtitle, freq )
% calculate (and plot) the individual frquency of a user at a location
% ================================
% Input:
%       ua, ub --- the user ID range in (1-95)
%       records --- the records set
%       figtitle --- the title of figure (if plot)
%       freq --- the meeting frequency of two users (for plotting)
% Output:
%       locs_f --- the frequencies of two users visiting the locations
%       locIDmap --- the location uninon is mapped with continuous ID

ra = records(records(:,1) == ua, :);
rb = records(records(:,1) == ub, :);

rec_all = [ra; rb];
% size(unique(rec_all(:,3)), 1) is the number of records
unique_locs = unique(rec_all(:,3));
locs_f = zeros( size(unique_locs, 1),    2);

for i = 1:size(unique_locs,1)
    loc = unique_locs(i);
    loc_id = unique_locs==loc;
    % calculate user a visiting loc freq
    locs_f(loc_id,1) = sum(ra(:,3)==loc);
    % calculate user b visiting loc freq
    locs_f(loc_id,2) = sum(rb(:,3)==loc);
end

% plot
if nargin > 3
    figure();
    plot(locs_f)
    legend({num2str(ua), num2str(ub)});
    title([figtitle, num2str(freq)]);
end

locIDmap = unique_locs;
end

