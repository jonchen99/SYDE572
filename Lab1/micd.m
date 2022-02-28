function class = micd(mu1, mu2, cov1, cov2, points)
    class = zeros(size(points,1),1);
      
    for i = 1:length(points)
        d1 = sqrt((points(i,:) - mu1) * inv(cov1) * (points(i,:) - mu1)');
        d2 = sqrt((points(i,:) - mu2) * inv(cov2) * (points(i,:) - mu2)');
        if (d1 < d2)
            class(i) = 1;
        elseif (d2 < d1)
            class(i) = 2;
        else
            class(i) = 0;
        end
    end
end

