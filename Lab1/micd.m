function z = micd(mu1, mu2, cov1, cov2, X, Y)
    
    class = zeros(size(X,1)*size(Y,2),1);
    grid = [X(:) Y(:)];
      
    for i = 1:length(grid)
        d1 = sqrt((grid(i,:) - mu1) * cov1 \ (grid(i,:) - mu1)');
        d2 = sqrt((grid(i,:) - mu2) * cov2 \ (grid(i,:) - mu2)');
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

