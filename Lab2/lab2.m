%% MODEL ESTIMATION 1-D CASE
clc
clear;
close all;

load('lab2_1.mat');

trueMeanA = 5;
trueSDA = 1;
trueLambdaB = 1;

% minA = min(a);
% maxA = max(a);
% minB = min(b);
% maxB = max(b);
% 
% xA = linspace(minA, maxA, 100);
% xB = linspace(minB, maxB, 100);
xA = 0:0.01:10;
xB = 0:0.01:10;

% Model Estimation 1-D case
% PARAMETRIC ESTIMATION - GAUSSIAN
% Data set A
[muA, varA] = estimateGaussianParams(a);
gaussianEstimateA = calculateGaussianPDF(xA, muA, sqrt(varA));
gaussianTrueA = calculateGaussianPDF(xA, trueMeanA, trueSDA);

% Data set B
[muB, varB] = estimateGaussianParams(b);
gaussianEstimateB = calculateGaussianPDF(xB, muB, sqrt(varB));
exponentialTrueB = calculateExponentialPDF(xB, trueLambdaB);

figure
title("Gaussian Parametric Estimation");
hold on
plot(xA, gaussianEstimateA);
plot(xA, gaussianTrueA);
plot(xB, gaussianEstimateB);
plot(xB, exponentialTrueB);
hold off
legend("Estimated $$\hat{p}$$(x) a", "True p(x) a", ...
    "Estimated $$\hat{p}$$(x) b", "True p(x) b", 'Interpreter', 'latex');
xlabel("x");
ylabel("p(x)");

% PARAMETRIC ESTIMATION - EXPONENTIAL
% Data set A
estLambdaA = estimateExponentialParams(a);
exponentialEstimateA = calculateExponentialPDF(xA, estLambdaA);
gaussianTrueA = calculateGaussianPDF(xA, trueMeanA, trueSDA);

% Data set B
estLambdaB = estimateExponentialParams(b);
exponentialEstimateB = calculateExponentialPDF(xB, estLambdaB);
exponentialTrueB = calculateExponentialPDF(xB, trueLambdaB);

figure
title("Exponential Parametric Estimation");
hold on
plot(xA, exponentialEstimateA);
plot(xA, gaussianTrueA);
plot(xB, exponentialEstimateB);
plot(xB, exponentialTrueB);
hold off
legend("Estimated $$\hat{p}$$(x) a", "True p(x) a", ...
    "Estimated $$\hat{p}$$(x) b", "True p(x) b", 'Interpreter', 'latex');
xlabel("x");
ylabel("p(x)");

% PARAMETRIC ESTIMATION - UNIFORM
% Data set A
[estA_A, estB_A] = estimateUniformParams(a);
uniformEstimateA = calculateUniformPDF(xA, estA_A, estB_A);
gaussianTrueA = calculateGaussianPDF(xA, trueMeanA, trueSDA);

% Data set B
[estA_B, estB_B] = estimateUniformParams(b);
uniformEstimateB = calculateUniformPDF(xB, estA_B, estB_B);
exponentialTrueB = calculateExponentialPDF(xB, trueLambdaB);

figure
title("Uniform Parametric Estimation");
hold on
plot(xA, uniformEstimateA);
plot(xA, gaussianTrueA);
plot(xB, uniformEstimateB);
plot(xB, exponentialTrueB);
hold off
legend("Estimated $$\hat{p}$$(x) a", "True p(x) a", ...
    "Estimated $$\hat{p}$$(x) b", "True p(x) b", 'Interpreter', 'latex');
xlabel("x");
ylabel("p(x)");

% NON-PARAMETRIC ESTIMATION
sd1 = 0.1;
sd2 = 0.4;

% Data set A
parzenEstimate1A = parzen1D(a, xA, sd1);
parzenEstimate2A = parzen1D(a, xA, sd2);
gaussianTrueA = calculateGaussianPDF(xA, trueMeanA, trueSDA);

% Data set B
parzenEstimate1B = parzen1D(b, xB, sd1);
parzenEstimate2B = parzen1D(b, xB, sd2);
exponentialTrueB = calculateExponentialPDF(xB, trueLambdaB);

figure
title("Parzen Non-Parametric Estimation for \sigma= " + sd1);
hold on
plot(xA, parzenEstimate1A);
plot(xA, gaussianTrueA);
plot(xB, parzenEstimate1B);
plot(xB, exponentialTrueB);
hold off
legend("Parzen Estimate for a", "True p(x) for a", "Parzen Estimate for b", "True p(x) for b");
xlabel("x");
ylabel("p(x)");

figure
title("Parzen Non-Parametric Estimation for \sigma= " + sd2);
hold on
plot(xA, parzenEstimate2A);
plot(xA, gaussianTrueA);
plot(xB, parzenEstimate2B);
plot(xB, exponentialTrueB);
hold off
legend("Parzen Estimate for a", "True p(x) for a", "Parzen Estimate for b", "True p(x) for b");
xlabel("x");
ylabel("p(x)");

%% MODEL ESTIMATION 2-D CASE

load('lab2_2.mat');

% PARAMETRIC ESTIMATION
% calculate mean and covariance 
muA = mean(al);
muB = mean(bl);
muC = mean(cl);
covA = cov(al);
covB = cov(bl);
covC = cov(cl);

resolution = 0.5;
cmap = colormap( ...
    [242/256 255/256 240/256; ...
    241/256 251/256 254/256; ...
    250/256 228/256 231/256] ...
    );


% create grid
minX = min([al(:,1);bl(:,1);cl(:,1)]);
maxX = max([al(:,1);bl(:,1);cl(:,1)]);
minY = min([al(:,2);bl(:,2);cl(:,2)]);
maxY = max([al(:,2);bl(:,2);cl(:,2)]);
x = minX:resolution:maxX+resolution;
y = minY:resolution:maxY+resolution;
[X, Y] = meshgrid(x,y);

% find boundary
ml_abc = classifyGrid(X, Y, @(points) ml(muA, muB, muC, covA, covB, covC, points));



% NON-PARAMETRIC ESTIMATION
h = 20;

ksize = round(12*h/resolution);
x = resolution.*(-ksize:(ksize+1));
kernel = exp(-resolution.*x.*x/(h*h));

res = [resolution, minX, minY, maxX, maxY];

[pAL, xAL, yAL] = parzen(al,res,kernel);
[pBL, xBL, yBL] = parzen(bl,res,kernel);
[pCL, xCL, yCL] = parzen(cl,res,kernel);

ml2_abc = ml2(pAL,pBL,pCL);

% plot 
figure
hold on 
colormap(cmap)
contourf(X, Y, ml_abc, 'Color', 'black');
scatter(al(:,1), al(:,2), '.', 'green');
scatter(bl(:,1), bl(:,2), '.', 'blue');
scatter(cl(:,1), cl(:,2), '.', 'red');
title('Parametric Estimation')
legend('boundary','al', 'bl', 'cl')
hold off

figure
hold on
contourf(X, Y, ml2_abc, 'Color', 'black');
colormap(cmap)
scatter(al(:,1), al(:,2), '.', 'green');
scatter(bl(:,1), bl(:,2), '.', 'blue');
scatter(cl(:,1), cl(:,2), '.', 'red');
legend('boundary','al', 'bl', 'cl')
title('Non-parametric Estimation')
hold off
%% SEQUENTIAL DISCRIMINANTS
data3 = load('lab2_3.mat');
% MED classification meshgrid
x1 = linspace(min([a(:,1);b(:,1)]), max([a(:,1);b(:,1)]), 100);
y1 = linspace(min([a(:,2);b(:,2)]), max([a(:,2);b(:,2)]), 100);

% 3 sequential classifiers for Q1
sequentialEstimation(x1,y1,a,b,1,1);
sequentialEstimation(x1,y1,a,b,1,2);
sequentialEstimation(x1,y1,a,b,1,3);

% Learning a sequential classifier 20 times for Q3 for J = 5
sequentialEstimation(x1,y1,a,b,5,0);