function class = micd3(mu1, mu2, mu3, cov1, cov2, cov3, points)
    class = zeros(size(points,1),1);

    for i = 1:length(points)
        d1 = sqrt((points(i,:) - mu1) * inv(cov1) * (points(i,:) - mu1)');
        d2 = sqrt((points(i,:) - mu2) * inv(cov2) * (points(i,:) - mu2)');
        d3 = sqrt((points(i,:) - mu3) * inv(cov3) * (points(i,:) - mu3)');
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
end
