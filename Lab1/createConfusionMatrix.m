function C = createConfusionMatrix(clusters, classifier)
    actual = [];
    predicted = [];
    
    for i = 1:numel(clusters)
        cluster = clusters{i};
        n = size(cluster,1);

        actual = [actual, ones(1, n) * i];
        predicted = [predicted, classifier(cluster).'];
    end
    
    predicted(predicted == 0) = NaN;
    
    C = confusionmat(actual,predicted);
end
