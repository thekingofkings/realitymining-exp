% load in the records
records = importdata('data\reality_matrix_2hs.txt');
records(:,1) = records(:,1) + 1;

% calculate the pairwise frequency
freq = zeros(4465, 1);
c = 1;
for i = 1:95
    for j = i:95
        freq(c) = pairColocateFreq(i,j,records);
        c = c + 1;
    end
end


        