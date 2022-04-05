function sequentialEstimation(x1,y1,A,B,J,num)
    [discriminants, true_n_ab, true_n_ba] = sequentialClassifier(A,B,0);

    if (J == 1)
        lenX = numel(x1);
        lenY = numel(y1);
        [X,Y] = meshgrid(x1,y1);

        estimates = zeros(lenX,lenY);
        for i = 1:lenX
           for j = 1:lenY
                estimates(i,j) = classifyClasses(J, X(i,j),Y(i,j), discriminants, true_n_ab, true_n_ba);
           end
        end

        plotSequentialClassifier(A,B,x1,y1,estimates,num);
    end
    if (J > 1)
        [avgError,minError,maxError,sdError] = calculateError(A,B,J,20);
        plotError(maxError,'Maximum Error Rate');
        plotError(sdError,'Standard Deviation of Error Rate');
        plotError(avgError,'Average Error Rate');
        plotError(minError,'Minimum Error Rate');

    end
end
