function z = micd3(mu1, mu2, mu3, cov1, cov2, cov3, X, Y)

    class = zeros(size(X,1)*size(Y,2),1);
    grid = [X(:) Y(:)];
    
    for i = 1:length(grid)
        d1 = sqrt((grid(i,:) - mu1) * cov1 \ (grid(i,:) - mu1)');
        d2 = sqrt((grid(i,:) - mu2) * cov2 \ (grid(i,:) - mu2)');
        d3 = sqrt((grid(i,:) - mu3) * cov3 \ (grid(i,:) - mu3)');
        if (d1 < d2 && d1 < d3)
            class(i) = 1;
        elseif (d2 < d1 && d2 < d3)
            class(i) = 2;
        elseif (d3 < d1 && d3 < d2)
            class(i) = 3;
        else
            class(i) = 0;
        end
    end
    z = reshape(class,size(X,1),size(X,2));
end
