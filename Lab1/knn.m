function z = knn(k,clusters,X,Y)
% KNN  Classify the points given by X, Y into classes corresponding to
%   the given clusters.
    points = [X(:) Y(:)];
    class = zeros(size(points,1),1);
    
    % Iterate over points which are to be classified.
    for i = 1:size(points,1)
        class_d = zeros(numel(clusters), 1);
        
        % Compute distance metric for each class.
        for j = 1:numel(clusters)
            cluster = clusters{j};

            % Compute distance from point to all points in cluster.
            d = ed(cluster, points(i, :));

            % Get k closest points.
            [~, k_closest_idx] = mink(d, k);

            % Compute prototype as mean of k closest points.
            p = mean(cluster(k_closest_idx, :),1);

            % Compute distance from point to prototype.
            class_d(j) = ed(p, points(i, :));
        end
        
        % Assign point to class with smallest distance metric.
        [~, closest_class] = min(class_d);
        class(i) = closest_class;
    end
    z = reshape(class,size(X,1),size(X,2));
end
