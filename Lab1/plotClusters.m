function plotClusters(mu, cov, col)
%   Determining the sorted eigenvalues/eigenvectors
    [evec, eval] = eigs(cov, 2);
    largerEvec = evec(:,1);
    largerEval = eval(1,1);
    smallerEval = evec(2,2);
    
    theta = atan2(largerEvec(2), largerEvec(1));
    a = sqrt(largerEval);
    b = sqrt(smallerEval);
    
    plot_ellipse(mu(1), mu(2), theta, a, b, col);
end