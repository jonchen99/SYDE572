function plotSequentialClassifier(A,B,x1,y1,G,num)
    [X,Y] = meshgrid(x1,y1);
    figure;
    title("Sequential Classifier " + num);
    hold on;
    scatter(A(:,1), A(:,2));
    hold on
    scatter(B(:,1), B(:,2));
    hold on
    contour(X, Y, G);
    xlabel('x-axis');
    ylabel('y-axis');
end
