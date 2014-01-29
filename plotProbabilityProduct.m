% plot pairwise probability product with error

load topk.mat;
% for non-friend pair
[nf_prod, nf_err] = probProdwithError( topk, 10 );

% for friend pair
[f_prod, f_err] = probProdwithError (topkF, 10);

figure()
hold on;
% barwitherr([nf_err; f_err]', [nf_prod; f_prod]');

bar([nf_prod; f_prod]')
legend({'Non-friend', 'Friend'}, 'fontsize', 14);
box on;
set(gca, 'fontsize', 14, 'linewidth', 2);
ylabel('Product of individual Probability', 'fontsize', 15);
xlabel('Frequency of meeting', 'fontsize', 15);