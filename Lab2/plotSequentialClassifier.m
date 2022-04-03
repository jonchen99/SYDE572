function plotSequentialClassifier(A,B,x1,y1,G,num)
    figure;
    [X,Y] = meshgrid(x1,y1);
    if (num == 0)
        title("Sequential Classifier ");
    else
        title("Sequential Classifier " + num);
    end
    
    xlabel('x-axis');
    ylabel('y-axis'); 
    hold on;
    scatter(A(:,1), A(:,2));
    
    hold on
    scatter(B(:,1), B(:,2));
    
    hold on
    contour(X, Y, G);
    
end