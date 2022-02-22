function z=med(mu1,mu2,X,Y)

    class = zeros(size(X,1)*size(Y,2),1);
    grid = [X(:) Y(:)];
    for i = 1:length(grid)
        d1 = sqrt((mu1(1) - grid(i,1))^2 + (mu1(2) - grid(i,2))^2);
        d2 = sqrt((mu2(1) - grid(i,1))^2 + (mu2(2) - grid(i,2))^2);
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
