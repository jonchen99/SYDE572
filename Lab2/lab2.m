%% MODEL ESTIMATION 1-D CASE
clc
clear;
close all;

load('lab2_1.mat');

meanA = 5;
sdA = 1;
lambdaB = 1;

minA = min(a);
maxA = max(a);
minB = min(b);
maxB = max(b);

xA = linspace(minA, maxA, 100);
xB = linspace(minB, maxB, 100);

% PARAMETRIC ESTIMATION - GAUSSIAN
% Data set A
[muA, varA] = estimateGaussianParams(a);
gaussianEstimateA = calculateGaussianPDF(xA, muA, sqrt(varA));
gaussianTrueA = calculateGaussianPDF(xA, meanA, sdA);

figure
title("Gaussian Parametric Estimation of Data Set A");
hold on
plot(xA, gaussianEstimateA);
plot(xA, gaussianTrueA);
hold off
legend("Estimated $$\hat{p}$$(x)", "True p(x)", 'Interpreter', 'latex');
xlabel("x");
ylabel("p(x)");

% Data set B
[muB, varB] = estimateGaussianParams(b);
gaussianEstimateB = calculateGaussianPDF(xB, muB, sqrt(varB));
exponentialTrueB = calculateExponentialPDF(xB, lambdaB);

figure
title("Gaussian Parametric Estimation of Data Set B");
hold on
plot(xB, gaussianEstimateB);
plot(xB, exponentialTrueB);
hold off
legend("Estimated $$\hat{p}$$(x)", "True p(x)", 'Interpreter', 'latex');
xlabel("x");
ylabel("p(x)");

% PARAMETRIC ESTIMATION - EXPONENTIAL
% Data set A
estLambdaA = estimateExponentialParams(a);
exponentialEstimateA = calculateExponentialPDF(xA, estLambdaA);
gaussianTrueA = calculateGaussianPDF(xA, meanA, sdA);

figure
title("Exponential Parametric Estimation of Data Set A");
hold on
plot(xA, exponentialEstimateA);
plot(xA, gaussianTrueA);
hold off
legend("Estimated $$\hat{p}$$(x)", "True p(x)", 'Interpreter', 'latex');
xlabel("x");
ylabel("p(x)");

% Data set B
estLambdaB = estimateExponentialParams(b);
exponentialEstimateB = calculateExponentialPDF(xB, estLambdaB);
exponentialTrueB = calculateExponentialPDF(xB, lambdaB);

figure
title("Exponential Parametric Estimation of Data Set B");
hold on
plot(xA, exponentialEstimateB);
plot(xA, exponentialTrueB);
hold off
legend("Estimated $$\hat{p}$$(x)", "True p(x)", 'Interpreter', 'latex');
xlabel("x");
ylabel("p(x)");

% PARAMETRIC ESTIMATION - UNIFORM
% Data set A


% Data set B

% NON-PARAMETRIC ESTIMATION
% Data set A


% Data set B
%% MODEL ESTIMATION 2-D CASE
data2 = load('lab2_2.mat');


%% SEQUENTIAL DISCRIMINANTS
data3 = load('lab2_3.mat');
