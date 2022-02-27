function z=map3(mu1,mu2,mu3,sigma1,sigma2,sigma3,n1,n2,n3,X,Y)

    class = zeros(size(X,1)*size(Y,2),1); % 1d arary of all points' classes
    grid = [X(:) Y(:)]; % 

    pA = n1 / (n1 + n2 + n3);
    pB = n2 / (n1 + n2 + n3);
    pC = n3 / (n1 + n2 + n3);


    for i = 1:length(grid)    
        x = [grid(i,1), grid(i,2)];

          pxA =  1/(sqrt(2*pi)*det(sigma1))*exp(-0.5*(x-mu1)*inv(sigma1)*(x-mu1)');
          pxB =  1/(sqrt(2*pi)*det(sigma2))*exp(-0.5*(x-mu2)*inv(sigma2)*(x-mu2)');
          pxC =  1/(sqrt(2*pi)*det(sigma3))*exp(-0.5*(x-mu3)*inv(sigma3)*(x-mu3)');

          logLike1 = log(pxA/pxB);
          logTheta1 = log(pB/pA);

          logLike2 = log(pxB/pxC);
          logTheta2 = log(pC/pB);

          logLike3 = log(pxC/pxA);
          logTheta3 = log(pA/pC);
                    
        
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
    z = reshape(class,size(X,1),size(X,2));
end
