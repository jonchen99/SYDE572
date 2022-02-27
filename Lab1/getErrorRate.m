function errorRate = getErrorRate(confusionMatrix)
    % TODO: this does not account for NaN values.
    total = sum(confusionMatrix, 'all');
    correct = sum(diag(confusionMatrix));
    errors = total - correct;
    errorRate = errors / total;
end
