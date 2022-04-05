function plotSequentialClassifier(A,B,x1,y1,G,n_ab,n_ba,num)
    lenX = numel(x1);
    lenY = numel(y1);
    [X,Y] = meshgrid(x1,y1);

    predictions = zeros(lenX,lenY);
    for i = 1:lenX
       for j = 1:lenY
            predictions(i,j) = sequentialInference(X(i,j), Y(i,j), G, n_ab, n_ba);
       end
    end

    figure;
    title("Sequential Classifier " + num);
    hold on;
    scatter(A(:,1), A(:,2));
    hold on
    scatter(B(:,1), B(:,2));
    hold on
    contour(X, Y, predictions);
    xlabel('x-axis');
    ylabel('y-axis');
end
