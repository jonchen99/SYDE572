function p = calculateGaussianPDF(x, mean, sd)
    p = zeros(length(x),1);
    for i=1:length(x)
        p(i) = exp((-((x(i)-mean).^2)) / (2*sd^2)) / (sd*sqrt(2*pi));
    end
end
