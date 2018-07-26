function W = sample_weights(n, d)
%% SAMPLE_WEIGHTS Returns a uniformly distributed set of normalized weights.
%
%  INPUT:
%      n : Number of independent weight vectors to return
%      d : Number of feature dimensions
%
%  OUTPUT:
%      W : <n x d> matrix of normalized weight vectors
%
%  Author:
%      Andrew Buck (7/26/2018)
%%

W = rand(n, d-1);
W = diff([zeros(n,1), sort(W,2), ones(n,1)], 1, 2);
