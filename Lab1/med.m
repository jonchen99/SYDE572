function class = med(mu, points)
    class = zeros(size(points,1),1);

    for i = 1:length(points)
        d = ed(mu, points(i,:));
        [dMin, classIndex] = min(d);

        if sum(d == dMin) > 1
            % Same distance for multiple classes. Undetermined.
            class(i) = 0;
        else
            class(i) = classIndex;
        end
    end
end
