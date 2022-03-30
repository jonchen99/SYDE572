function p = calculateExponentialPDF(x,lambda)
    p = zeros(length(x),1);
    for i=1:length(x)
        p(i) = lambda*exp(-lambda*x(i));
    end
end
