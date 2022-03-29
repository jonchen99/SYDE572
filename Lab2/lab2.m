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

% PARAMETRIC ESTIMATION - GAUSSIAN
% Data set A
[muA, varA] = estimateGaussianParams(a);
gaussianEstimateA = calculateGaussianPDF(xA, muA, sqrt(varA));
gaussianTrueA = calculateGaussianPDF(xA, trueMeanA, trueSDA);

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
exponentialTrueB = calculateExponentialPDF(xB, trueLambdaB);

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
gaussianTrueA = calculateGaussianPDF(xA, trueMeanA, trueSDA);

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
exponentialTrueB = calculateExponentialPDF(xB, trueLambdaB);

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
[estA_A, estB_A] = estimateUniformParams(a);
uniformEstimateA = calculateUniformPDF(xA, estA_A, estB_A);
gaussianTrueA = calculateGaussianPDF(xA, trueMeanA, trueSDA);

figure
title("Uniform Parametric Estimation of Data Set A");
hold on
plot(xA, uniformEstimateA);
plot(xA, gaussianTrueA);
hold off
legend("Estimated $$\hat{p}$$(x)", "True p(x)", 'Interpreter', 'latex');
xlabel("x");
ylabel("p(x)");

% Data set B
[estA_B, estB_B] = estimateUniformParams(b);
uniformEstimateB = calculateUniformPDF(xB, estA_B, estB_B);
exponentialTrueB = calculateExponentialPDF(xB, trueLambdaB);

figure
title("Uniform Parametric Estimation of Data Set B");
hold on
plot(xB, uniformEstimateB);
plot(xB, exponentialTrueB);
hold off
legend("Estimated $$\hat{p}$$(x)", "True p(x)", 'Interpreter', 'latex');
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
data2 = load('lab2_2.mat');


%% SEQUENTIAL DISCRIMINANTS
data3 = load('lab2_3.mat');
