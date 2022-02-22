function z=med(mu1,mu2,X,Y)
    mean1 = transpose(mu1);
    mean2 = transpose(mu2);
    class = zeros(size(X,1)*size(Y,2),1);
    grid = [X(:) Y(:)];
    for i = 1:length(grid)
        d1 = sqrt((mean1(1) - grid(i,1))^2 + (mean1(2) - grid(i,2))^2);
        d2 = sqrt((mean2(1) - grid(i,1))^2 + (mean2(2) - grid(i,2))^2);
        if (d1 < d2)
            class(i) = 1;
        elseif (d2 < d1)
            class(i) = 2;
        else
            class(i) = 0;
        end
    end
    z = reshape(class,size(X,1),size(X,2));
end
