function plotClusters(mu, cov, col)
    [evec, eval] = eig(cov);
    if eval(1,1)>=eval(2,2)
        largerEvec = evec(:,1);
        theta = atan(largerEvec(2)/largerEvec(1));
        largerEval = eval(1,1);
        smallerEval = eval(2,2);
    else
        largerEvec = evec(:,2);
        theta = atan(largerEvec(2)/largerEvec(1));
        largerEval = eval(2,2);
        smallerEval = eval(1,1);
        
    end
    a = sqrt(largerEval);
    b = sqrt(smallerEval);
    plot_ellipse(mu(1),mu(2),theta,a,b, col);

end
