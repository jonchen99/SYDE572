function [mu, variance] = estimateGaussianParams(data)
    N = length(data);
    
    % ML estimate for mean
    mu = mean(data);
    
    % ML estimate for variance
    % var function in matlab uses N-1 denominator  
    % -> ML estimate should be normalized by N instead
    variance = var(data) * (N-1) / N;
end
