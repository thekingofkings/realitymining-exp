function [totalFre, uniq_coloc, coloc_fre, coloc, times] = pairColocateFreq( ua, ub, records ) 
% calculate co-locating frequency of a pair of users 
% =====================================
% Input:
%       ua, ub  --- user ID range in (1-95)
%       records --- the records set
% Output:
%       totalFre --- the total meeting frequency of two user
%       uniq_coloc --- the locations where they meet
%       coloc_fre  --- the co-location frequency of each co-locating place



ra = records(records(:,1) == ua, :);
rb = records(records(:,1) == ub, :);

ia = 1;
ib = 1;
coloc = zeros(1,1);
times = zeros(1,1);
c = 1;
while ia <= size(ra,1) && ib <= size(rb,1)
    if ra(ia,2) > rb(ib,2)
        ib = ib + 1;
        continue
    else if ra(ia,2) < rb(ib,2)
            ia = ia + 1;
            continue
        else if ra(ia,3) == rb(ib,3)
               coloc(c) = ra(ia,3);
               times(c) = ra(ia,2);
               c = c + 1;
            end
            ia = ia + 1;
            ib = ib + 1;
        end
    end
end
uniq_coloc = unique(coloc);
coloc_fre = zeros(size(uniq_coloc));
for i = 1:length(uniq_coloc)
    coloc_fre(i) = sum(coloc==uniq_coloc(i));
end
totalFre = c - 1;
end
