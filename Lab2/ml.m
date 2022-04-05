function class = ml(mu1, mu2, mu3, sigma1, sigma2, sigma3, points)
    class = zeros(size(points,1),1);
    for i = 1:length(points)
        x = [points(i,1), points(i,2)];

        pxA =  1/(sqrt(2*pi)*det(sigma1))*exp(-0.5*(x-mu1)*inv(sigma1)*(x-mu1)');
        pxB =  1/(sqrt(2*pi)*det(sigma2))*exp(-0.5*(x-mu2)*inv(sigma2)*(x-mu2)');
        pxC =  1/(sqrt(2*pi)*det(sigma3))*exp(-0.5*(x-mu3)*inv(sigma3)*(x-mu3)');

        logLike1 = log(pxA/pxB);
        logTheta1 = 0;

        logLike2 = log(pxB/pxC);
        logTheta2 = 0;

        logLike3 = log(pxC/pxA);
        logTheta3 = 0;


        if (logLike1 > logTheta1 && logLike3 < logTheta3)
            class(i) = 1; % A
        elseif (logLike1 < logTheta1  && logLike2 > logTheta2)
            class(i) = 2; % B
        elseif (logLike2 < logTheta2  && logLike3 > logTheta3)
            class(i) = 3; % C
        else
            class(i) = 0;
        end
    end
end
