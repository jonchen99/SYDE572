function [avgError,minError,maxError,sdError] = sequentialError(A,B,J,K)
    for j=1:J
        errorRate = [];
        for k=1:K
            lenA = size(A,1);
            lenB = size(B,1);
            errors = 0;

            % Get classifiers
            [G,n_ab,n_ba] = sequentialClassifier(A,B,j);

            % Check each point in dataset A
            for i=1:lenA
                x = A(i,:);
                x_class = sequentialInference(x(1),x(2),G,n_ab,n_ba);

                % Misclassified
                if (x_class == 2)
                    errors = errors + 1;
                end
            end

            % Check each point in dataset B
            for i=1:lenB
                x = B(i,:);
                x_class = sequentialInference(x(1),x(2),G,n_ab,n_ba);

                % Misclassified
                if (x_class == 1)
                    errors = errors + 1;
                end
            end

            errorRate(k) = errors/(lenA + lenB);
        end

        % Calculate the various error rates:
        avgError(j) = mean(errorRate);
        minError(j) = min(errorRate);
        maxError(j) = max(errorRate);
        sdError(j) = std2(errorRate);
    end
end
