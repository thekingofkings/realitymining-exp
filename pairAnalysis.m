% Pairwise frequency and probability analysis
clear topk topkF;

%% calculate the pairwise colocation event
% load in the records
% records = importdata('data\reality_matrix_15min.txt');
% records(:,1) = records(:,1) + 1;
% 
% % calculate the pairwise frequency
% freq = zeros(4465, 1);
% c = 1;
% colocs = zeros(1,1);
% for i = 1:95
%     for j = i+1:95
%         [freq(c), colocs, coloc_fre] = pairColocateFreq(i,j,records);
%         pairwiseF(c,1).coloc = colocs;
%         pairwiseF(c,1).coloc_fre = coloc_fre;
%         c = c + 1;
%     end
% end
% 
% save pairwiseF.mat
% {
% pairwiseF
% ====================
% A 4465x1 struct array with fields:
%     f       -- co-location frequency
%     coloc   -- a sequence of co-location ID
% }

%% plot the pairwise location distribution of two cases

% plot the topk non-friend meet
% for i = 1:size(topk_nonfri_fre,1)
%     plotLocDistribution(nonfri_fre(i,1), topk_nonfri_fre(i,2), records, ...
%         'Non-friend meeting Freq', topk_nonfri_fre(i,3));
% end


% % plot less frequent friend meet
% for i = 1:size(nondup_fri_fre,1)
%     plotLocDistribution(nondup_fri_fre(i,1), nondup_fri_fre(i,2), ...
%         records, 'Friend meeting freq', nondup_fri_fre(i,3));
% end


%% get individual probability of appearing at colocating places.

load pairwiseF.mat
% 
% non-friend meet (infrequent case: 1-10)
c = 1;

for i = 1: size(nonfri_fre,1)
    % only consider infrequent pair
    if nonfri_fre(i,3) > 0 && nonfri_fre(i,3) <= 10
        ua = nonfri_fre(i,1);
        ub = nonfri_fre(i,2);
        pairID = sum(94:-1:94-ua+2) + (ub - ua);
        colocs = pairwiseF(pairID).coloc;
        colc_fre = pairwiseF(pairID).coloc_fre;
        [locsf, locIDmap] = pairLocDistribution(ua, ub, records);
        for j = 1:length(colocs);
            topk(c).prob(j,1:6) = [colocs(j), colc_fre(j), ua, ub, ...
                locsf(locIDmap==colocs(j),:) ./ sum(locsf)];
        end
        c = c + 1;
    end
end


%{
topk
====================
A 1x20 struct array with fields:
    prob   -- 6 columns, each means:
        locatoin ID, meeting frequency, user a, user b, probability of a, 
        probability of b
%}




% friend meet
c = 1;
for i = 1:size(nondup_fri_fre,1)
    if nondup_fri_fre(i,3) > 0 && nondup_fri_fre(i,3) <= 10
        ua = nondup_fri_fre(i,1);
        ub = nondup_fri_fre(i,2);
        pairID = sum(94:-1:94-ua+2) + (ub - ua);
        colocs = pairwiseF(pairID).coloc;
        colc_fre = pairwiseF(pairID).coloc_fre;
        [locsf, locIDmap] = pairLocDistribution(ua, ub, records);
        for j = 1:length(colocs);
            % there are meeting events
            if colocs > 0
                topkF(c).prob(j,1:6) = [colocs(j), colc_fre(j), ua, ub, ...
                    locsf(locIDmap==colocs(j),:) ./ sum(locsf)];
            end
            c = c + 1;
        end
    end
end

save('topk.mat', 'topk', 'topkF');

%{
topkF
====================
A 1x20 struct array with fields:
    prob   -- 6 columns, each means:
        locatoin ID, meeting frequency, user a, user b, probability of a, 
        probability of b
%}