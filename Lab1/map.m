function class=map(mu1,mu2,sigma1,sigma2,n1, n2, points)
    class = zeros(size(points,1),1); % 1d arary of all points' classes

    pA = n1 / (n1 + n2);
    pB = n2 / (n1 + n2);

    for i = 1:length(points)
        x = [points(i,1), points(i,2)];


        pxA =  1/(sqrt(2*pi)*det(sigma1))*exp(-0.5*(x-mu1)*inv(sigma1)*(x-mu1)');
        pxB =  1/(sqrt(2*pi)*det(sigma2))*exp(-0.5*(x-mu2)*inv(sigma2)*(x-mu2)');

        logLike = log(pxA/pxB);
        logTheta = log(pB/pA);

        if(logLike(1) > logTheta(1))
            class(i) = 1;
        elseif(logLike < logTheta)
            class(i) = 2;
        else
            class(i) = 0;
        end
    end
end
