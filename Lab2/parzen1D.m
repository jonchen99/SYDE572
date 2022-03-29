function [p] = parzen1D(data, x, sd)
    N = length(data);
    p = zeros(length(x),1);
    
    for i=1:length(x)
        sum = 0;
        for j=1:N
            sum = sum + exp(-0.5/sd^2*(data(j) - x(i))^2) / (sd*sqrt(2*pi));
        end
        p(i) = sum / N;
    end 
end
