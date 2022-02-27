function z=map(mu1,mu2,sigma1,sigma2,n1, n2,X,Y)
class = zeros(size(X,1)*size(Y,2),1); % 1d arary of all points' classes
grid = [X(:) Y(:)]; %

pA = n1 / (n1 + n2);
pB = n2 / (n1 + n2);


for i = 1:length(grid)
    x = [grid(i,1), grid(i,2)];


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
z = reshape(class,size(X,1),size(X,2));
end
