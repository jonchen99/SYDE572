function [avgError,minError,maxError,sdError] = calculateError(A,B,J,K)
    for j=1:J
        totalError = [];
        for k=1:K
            dataA = A;
            dataB = B;
            lenA = size(A,1);
            lenB = size(B,1);
            classA = zeros(size(A,1),1);
            classB = zeros(size(B,1),1);
            errorRate = 0;

            % Get classifiers
            [discriminants,true_n_ab,true_n_ba] = sequentialClassifier(dataA,dataB,J);

            % Check each point in dataset A
            for i=1:lenA
                x = A(i,:);
                classA(i) = classifyClasses(J,x(1),x(2),discriminants,true_n_ab,true_n_ba);

                % Misclassified
                if (classA(i) == 2)
                    errorRate = errorRate + 1;
                end
            end

            % Check each point in dataset B
            for i=1:lenB
                x = B(i,:);
                classB(i) = classifyClasses(J,x(1),x(2),discriminants,true_n_ab,true_n_ba);

                % Misclassified
                if (classB(i) == 1)
                    errorRate = errorRate + 1;
                end
            end

            % Calculate the total error:
            totalError(k) = errorRate/400;
        end

        % Calculate the various error rates:
        avgError(j) = mean(totalError);
        minError(j) = min(totalError);
        maxError(j) = max(totalError);
        sdError(j) = std2(totalError);
    end
end
