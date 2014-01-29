% load in the records
records = importdata('data\reality_matrix_15min.txt');
records(:,1) = records(:,1) + 1;

% calculate the pairwise frequency
freq = zeros(4465, 1);
c = 1;
for i = 1:95
    for j = i+1:95
        freq(c) = pairColocateFreq(i,j,records);
        c = c + 1;
    end
end

% plot the pairwise location distribution

% plot the topk non-friend meet
% for i = 1:size(topk_nonfri_fre,1)
%     plotLocDistribution(nonfri_fre(i,1), topk_nonfri_fre(i,2), records, ...
%         'Non-friend meeting Freq', topk_nonfri_fre(i,3));
% end


% plot less frequent friend meet
for i = 1:size(nondup_fri_fre,1)
    plotLocDistribution(nondup_fri_fre(i,1), nondup_fri_fre(i,2), ...
        records, 'Friend meeting freq', nondup_fri_fre(i,3));
end