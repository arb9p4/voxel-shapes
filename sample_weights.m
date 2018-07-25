function W = sample_weights(num_samples, num_features)

W = rand(num_samples, num_features-1);
W = diff([zeros(num_samples,1), sort(W,2), ones(num_samples,1)], 1, 2);
