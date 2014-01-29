%% friend pair id mapping
load('data\maps.mat');


% get all the friend pair in network.friends (94x94)
friend_pair = zeros(sum(nansum(friends_map)), 2);
c = 0;

for i = 1:size(friends_map, 1)
    for j = 1:size(friends_map, 2)
        if (friends_map(i,j) == 1)
            c = c + 1;
            friend_pair(c,:) = [i, j];
        end
    end
end

friend_pair = map94_106(friend_pair);

% get the reverse map from id(107 to id(95)
map107_95 = -1 * ones(1, 107);
for i = 1:size(map95_106,2)
    map107_95(map95_106(i)) = i;
end


for i = 1 : length(friend_pair)
    friend_pair(i,:) = map107_95(friend_pair(i,:));
end


% eliminate the -1 case
friend_pair = friend_pair(sum(friend_pair~=-1, 2)==2, :);


% eliminate dulplicate 
nondup_fri = zeros(1,2);
c = 1;
for i = 1: size(friend_pair, 1)
    t_ind = find(friend_pair(:,1) == friend_pair(i,2));
    if isempty(t_ind)
        nondup_fri(c,:) = [friend_pair(i,1), friend_pair(i,2)];
        c = c+1;
    else
        h_ind = find(friend_pair(t_ind,2) == friend_pair(i,1));
        if isempty(h_ind) 
            nondup_fri(c,:) = [friend_pair(i,1), friend_pair(i,2)];
            c = c+1;
        else if (friend_pair(i,1) < friend_pair(i,2))
            nondup_fri(c,:) = [friend_pair(i,1), friend_pair(i,2)];
            c = c+1;
            end
        end
    end
end

% reorder the friend pair
% make the little id first
for i = 1: size(nondup_fri,1)
    if nondup_fri(i,1) > nondup_fri(i,2)
        tmp = nondup_fri(i,2);
        nondup_fri(i,2) = nondup_fri(i,1);
        nondup_fri(i,1) = tmp;
    end
end

% sort them according to the first friend ID
[~, sid] = sort(nondup_fri(:,1));
nondup_fri = nondup_fri(sid, :);


%% get the friends frequency
load 'data\binarys.mat';
meeting_fre = freq;
fri_fre = zeros(size(nondup_fri, 1), 1);
for i = 1:size(nondup_fri, 1)
    pairID = sum(94:-1:94-i+2) + (j-i);
    fri_fre(i) = meeting_fre(pairID);
end

nondup_fri_fre = [nondup_fri, fri_fre];

%% get infrequent meeting friend pair
infreq_fri_fre = zeros(1,3);
ind = 1;
for i = 1:size(nondup_fri_fre,1)
    if nondup_fri_fre(i,3) < 10
        infreq_fri_fre(ind,:) = nondup_fri_fre(i,:);
        ind = ind + 1;
    end
end

        
% get the frequent meeting non-friend pair
nonfri_fre = zeros(1,3);
ind = 1;

for i = 1:95
    for j = i+1:95
        pairID = sum(94:-1:94-i+2) + (j-i);
        aind = find(nondup_fri(:,1)==i);
        if isempty(aind)
            nonfri_fre(ind,:) = [i, j, meeting_fre(pairID)];
            ind = ind + 1;
        else
            bind = find(nondup_fri(aind,2)==j);
            if isempty(bind)
                nonfri_fre(ind,:) = [i,j,meeting_fre(pairID)];
                ind = ind + 1;
            end
        end
    end
end

[~, si] = sort(nonfri_fre(:,3), 'descend');
nonfri_fre = nonfri_fre(si,:);


topk_nonfri_fre = nonfri_fre(1:20,:);
