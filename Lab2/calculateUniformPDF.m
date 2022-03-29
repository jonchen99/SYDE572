function p = calculateUniformPDF(x,a,b)
    p = zeros(length(x),1);
    for i=1:length(x)
        p(i) = 1/(b-a);
    end
    
%     exppdf(x, lambda);
end
