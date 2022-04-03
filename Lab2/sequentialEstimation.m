function sequentialEstimation(x1,y1,A,B,J,num)
    [discriminants, true_n_ab, true_n_ba] = sequentialClassifier(A,B,0);
    
    if (J == 1)
        lenX = numel(x1);
        lenY = numel(y1);
        [X,Y] = meshgrid(x1,y1);

        % Section 4 - Question 1 (J is Infinity) 
        % Get list of discriminants 
        estimation = zeros(lenX,lenY); 
        for i = 1:lenX
           for j = 1:lenY
                estimation(i,j) = classifyClasses(J, X(i,j),Y(i,j), discriminants, true_n_ab, true_n_ba);
           end
        end

        % Plot 
        plotSequentialClassifier(A,B,x1,y1,estimation,num);
    end
    if (J > 1)            
        num_calculations = 20; % Do calculations 20 times, as per required 
        [avgError,minError,maxError,sdError] = findError(A,B,J,num_calculations,discriminants,true_n_ab,true_n_ba); 
        
        plotError(avgError,'Average Error Rate');
        plotError(minError,'Minimum Error Rate');
        plotError(maxError,'Maximum Error Rate');
        plotError(sdError,'Standard Deviation of Error Rate');   
    end
end

function [avgError,minError,maxError,sdError] = findError(A,B,J,K,discriminants,true_n_ab,true_n_ba)
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