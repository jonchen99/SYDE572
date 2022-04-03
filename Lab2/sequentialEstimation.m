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
        [avgError,minError,maxError,sdError] = calculateError(A,B,J,num_calculations,discriminants,true_n_ab,true_n_ba); 
        
        plotError(avgError,'Average Error Rate');
        plotError(minError,'Minimum Error Rate');
        plotError(maxError,'Maximum Error Rate');
        plotError(sdError,'Standard Deviation of Error Rate');   
    end
end