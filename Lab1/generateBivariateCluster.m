function z = generateBivariateCluster(n, mu, cov)
    % Generate nx2 random values
    x = randn(n,2);
    [phi, lambda] = eig(cov);
    
    % Multiply by the inverse Generalized Euclidean Metric weight matrix
    % (need x' to get correct matrix multiplication dimensions
    w = phi * sqrt(lambda) * x';
    z = repmat(mu, n, 1) + w';
end
