function p = calculateUniformPDF(x,a,b)
    p = zeros(length(x),1);
    for i=1:length(x)
        if x(i) >= a && x(i) <=b
            p(i) = 1/(b-a);
        else 
            p(i) = 0;
        end
    end
end
