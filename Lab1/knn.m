function class = knn(k, clusters, points)
% Classify the points into classes corresponding to the given clusters.
    class = zeros(size(points,1),1);
    
    % Iterate over points which are to be classified.
    for i = 1:size(points,1)
        classD = zeros(numel(clusters), 1);
        
        % Compute distance metric for each class.
        for j = 1:numel(clusters)
            cluster = clusters{j};

            % Compute distance from point to all points in cluster.
            d = ed(cluster, points(i, :));

            % Get k closest points.
            [~, kClosestIndex] = mink(d, k);

            % Compute prototype as mean of k closest points.
            p = mean(cluster(kClosestIndex, :),1);

            % Compute distance from point to prototype.
            classD(j) = ed(p, points(i, :));
        end
        
        % Assign point to class with smallest distance metric.
        [dMin, classIndex] = min(classD);

        if sum(classD == dMin) > 1
            % Same distance for multiple classes. Undetermined.
            class(i) = 0;
        else
            class(i) = classIndex;
        end
    end
end
