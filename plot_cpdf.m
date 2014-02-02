[~, ind] = sort(nondup_fri_fre(:,3), 'descend');
sorted_nf = nondup_fri_fre(ind,:);
sorted_nf(sorted_nf(:,1)==24, :)

% [~, ind] = sort(nonfri_fre(:,3), 'descend');
% sorted_nf = nonfri_fre(ind,:);
% sorted_nf(sorted_nf(:,1)==24, :)

%%
ua = 24;
ub = 90;
[l1, l2] = pairLocDistribution(ua, ub, records);

[sorted1, ind1] = sort( l1(:,1), 'descend');
[sorted1, l2(ind1)];
[sorted2, ind2] = sort( l1(:,2), 'descend');
[sorted2, l2(ind2)];

toplocs = [ind1(1:10, :), ind2(1:10, :)];

[totalFre, uniq_coloc, coloc_fre, coloc, times] = pairColocateFreq( ua, ub, records );

% find rank of unique locations
for i = 1:length(uniq_coloc)
    ulc = uniq_coloc(i);
    ulc_fre = coloc_fre(i);
    rank_a = find(l2(ind1) == ulc);
    rank_b = find(l2(ind2) == ulc);
    visit_num_a = sorted1(rank_a);
    visit_num_b = sorted2(rank_b);
    [ulc, ulc_fre,  rank_a, visit_num_a, rank_b, visit_num_b]
end

total = sum(sorted1);

ps = zeros(size(sorted1));
cnt = 0;
for i = 1:length(sorted1)
    cnt = cnt + sorted1(i);
    ps(i) = cnt / total;
end
%%
% plot(ps);
% grid on
% set(gca, 'xscale', 'log');
    
%%
non_ua1 = nonfri_fre(nonfri_fre(:,1)==24, :);
non_ua2 = nonfri_fre(nonfri_fre(:,2)==24, :);