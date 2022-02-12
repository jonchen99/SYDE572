function z = generateBivariateCluster(n, mu, cov)
    R = chol(cov);
    z = repmat(mu, n, 1) + randn(n, 2)*R;
end
