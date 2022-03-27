function [lambda] = estimateExponentialParams(data)
    N = length(data);
    sum = 0;
    
    % ML estimate for lambda
    for i = 1:N
        sum = sum + data(i);
    end
    
    lambda = N / sum;
end
