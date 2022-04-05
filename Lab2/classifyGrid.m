function class = classifyGrid(X, Y, classifier)
% Classify points given by X, Y (meshgrid). Used to determine decision
%   boundaries.
    points = [X(:) Y(:)];
    class = classifier(points);
    class = reshape(class,size(X,1),size(X,2));
end
