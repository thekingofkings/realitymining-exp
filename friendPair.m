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
nonduplicate_f = zeros(1,2);
c = 1;
for i = 1: size(friend_pair, 1)
    t_ind = find(friend_pair(:,1) == friend_pair(i,2));
    if isempty(t_ind)
        nonduplicate_f(c,:) = [friend_pair(i,1), friend_pair(i,2)];
        c = c+1;
    else
        h_ind = find(friend_pair(t_ind,2) == friend_pair(i,1));
        if isempty(h_ind) 
            nonduplicate_f(c,:) = [friend_pair(i,1), friend_pair(i,2)];
            c = c+1;
        else if (friend_pair(i,1) < friend_pair(i,2))
            nonduplicate_f(c,:) = [friend_pair(i,1), friend_pair(i,2)];
            c = c+1;
            end
        end
    end
end


