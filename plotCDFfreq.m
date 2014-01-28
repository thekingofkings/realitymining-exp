%{
Plot the CDF of frequency distribution of different pair cases
=====================


Data file explanation
---------------------
There are three different cases:
    * Friends pair
    * Non-friends pair
    * Overall pair

The data file we will use is:
    data/binarys.mat

From the data file we will load the following variables:
    * binary_affliation
    * binary_friend
    * binary_group
    * meeting_fre
They are all statistics on each pair. In total, we have 95 users, so there
are nchoosek(95, 2) = 4465 pairs. For each pair we mark whether they are in
the same affiliation; they are in the same group; they are friends, and the
meetring frequency between them.


Observations
---------------------
From the meeting_fre, we can see that there are 68 friends pair in total.
Because the friend information is obtained from survey. And there are
friend relationship that is only one way.

%}

load('data/binarys.mat');

figure();
hold on;
box on;
% friends
freq_friends = meeting_fre(binary_friend==1);
l1 = cdfplot( freq_friends );
set(l1, 'color', 'red', 'linewidth', 2);

% non-friends
freq_nonfriends = meeting_fre(binary_friend==0);
l2 = cdfplot ( freq_nonfriends );
set(l2, 'color', 'blue', 'linewidth', 2);

% over all
l3 = cdfplot( meeting_fre );
set(l3, 'color', 'green', 'linewidth', 2, 'linestyle', ':');

legend({'Friends', 'Non-friends', 'All'}, 'fontsize', 14);
set(gca, 'fontsize', 14);
xlabel('CDF of meeting frequency', 'fontsize', 16);
ylabel('Meeting frequency', 'fontsize', 16);
title('');
print('fig/cdfFreq.eps', '-dpsc');
system('epstopdf fig/cdfFreq.eps');