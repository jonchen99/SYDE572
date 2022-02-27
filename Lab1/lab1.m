clc;
close all;
clear;

% Defining the five classes of data
N_a = 200; mu_a = [5 10]; cov_a = [8 0; 0 4];
N_b = 200; mu_b = [10 15]; cov_b = [8 0; 0 4];
N_c = 100; mu_c = [5 10]; cov_c = [8 4; 4 40];
N_d = 200; mu_d = [15 10]; cov_d = [8 0; 0 8];
N_e = 150; mu_e = [10 5]; cov_e = [10 -5; -5 20];

% Generating each of the clusters
clusterA = generateBivariateCluster(N_a, mu_a, cov_a);
clusterB = generateBivariateCluster(N_b, mu_b, cov_b);
clusterC = generateBivariateCluster(N_c, mu_c, cov_c);
clusterD = generateBivariateCluster(N_d, mu_d, cov_d);
clusterE = generateBivariateCluster(N_e, mu_e, cov_e);

% Generating the grid of points for Case 1
minABx = min([clusterA(:,1);clusterB(:,1)]);
maxABx = max([clusterA(:,1);clusterB(:,1)]);
minABy = min([clusterA(:,2);clusterB(:,2)]);
maxABy = max([clusterA(:,2);clusterB(:,2)]);

x = linspace(minABx, maxABx, 500);
y = linspace(minABy, maxABy, 500);
[X1, Y1] = meshgrid(x,y);

% Generating the grid of points for Case 2
minCDEx = min([clusterC(:,1);clusterD(:,1);clusterE(:,1)]);
maxCDEx = max([clusterC(:,1);clusterD(:,1);clusterE(:,1)]);
minCDEy = min([clusterC(:,2);clusterD(:,2);clusterE(:,2)]);
maxCDEy = max([clusterC(:,2);clusterD(:,2);clusterE(:,2)]);

x2 = linspace(minCDEx, maxCDEx, 500);
y2 = linspace(minCDEy, maxCDEy, 500);
[X2, Y2] = meshgrid(x2,y2);

scatterSize = 15;

%% 

% Plotting the samples and unit standard deviation countour for classes A and B
figure(1)
hold on

samplesA = scatter(clusterA(:,1), clusterA(:,2), scatterSize, 'r', 'filled');
plotClusters(mu_a, cov_a, 'r');

samplesB = scatter(clusterB(:,1), clusterB(:,2), scatterSize, 'b', 'filled');
plotClusters(mu_b, cov_b, 'b');

title('Plot of Samples and Clusters of Classes A and B')
legend([samplesA, samplesB], {'Class A', 'Class B'})
xlabel('x'); ylabel('y');
hold off

% Plotting the samples and unit standard deviation countour for classes C,
% D, and E
figure(2)
hold on

samplesC = scatter(clusterC(:,1), clusterC(:,2), scatterSize, 'r', 'filled');
plotClusters(mu_c, cov_c, 'r');

samplesD = scatter(clusterD(:,1), clusterD(:,2), scatterSize, 'b', 'filled');
plotClusters(mu_d, cov_d, 'b');

samplesE = scatter(clusterE(:,1), clusterE(:,2), scatterSize, 'm', 'filled');
plotClusters(mu_e, cov_e, 'm');

title('Plot of Samples and Clusters of Classes C, D. and E')
legend([samplesC, samplesD, samplesE], {'Class C', 'Class D', 'Class E'})
xlabel('x'); ylabel('y');
hold off

%%

% Plotting MED, MICD, MAP decision boundaries for Case 1
med_ab = med(mu_a', mu_b', X1, Y1);
micd_ab = micd(mu_a', mu_b', cov_a, cov_b, X1, Y1);
% TODO: ADD MAP BOUNDARIES
figure(3)
hold on;
samplesA = scatter(clusterA(:,1), clusterA(:,2), scatterSize, 'r', 'filled');
samplesB = scatter(clusterB(:,1), clusterB(:,2), scatterSize, 'b', 'filled');
plotClusters(mu_a, cov_a, 'r');
plotClusters(mu_b, cov_b, 'b');

contour(X1, Y1, med_ab, 'Color', 'g');
contour(X1, Y1, micd_ab, 'Color', 'c');
% TODO: ADD MAP BOUNDARIES

title('MED, MICD, and MAP Classifications of A and B')
legend('Class A', 'Class B', 'Unit SD Contour A', 'Unit SD Contour B', 'MED', 'MICD')
xlabel('x'); ylabel('y');
hold off;


% Plotting MED, MICD, MAP decision boundaries for Case 2
med_cde = med3(mu_c', mu_d', mu_e', X2, Y2);
micd_cde = micd3(mu_c', mu_d', mu_e', cov_c, cov_d, cov_e, X2, Y2);
% ADD MAP BOUNDARIES

figure(4)
hold on;
samplesC = scatter(clusterC(:,1), clusterC(:,2), scatterSize, 'r', 'filled');
samplesD = scatter(clusterD(:,1), clusterD(:,2), scatterSize, 'b', 'filled');
samplesE = scatter(clusterE(:,1), clusterE(:,2), scatterSize, 'm', 'filled');

plotClusters(mu_c, cov_c, 'r');
plotClusters(mu_d, cov_d, 'b');
plotClusters(mu_e, cov_e, 'm');

contour(X2, Y2, med_cde, 'Color', 'g');
contour(X2, Y2, micd_cde, 'Color', 'c');

% ADD MAP BOUNDARIES
title('MED, MICD, and MAP Classifications of C, D, and E')
legend('Class C', 'Class D', 'Class E', 'Unit SD Contour C', 'Unit SD Contour D', 'Unit SD Contour E','MED', 'MICD')
xlabel('x'); ylabel('y');
hold off;

%%

% Plotting NN, 5NN decision boundaries for Case 1
nn_ab = knn(1, {clusterA, clusterB}, X1, Y1);
knn_ab = knn(5, {clusterA, clusterB}, X1, Y1);
figure(5)
hold on;
samplesA = scatter(clusterA(:,1), clusterA(:,2), scatterSize, 'r', 'filled');
samplesB = scatter(clusterB(:,1), clusterB(:,2), scatterSize, 'b', 'filled');
plotClusters(mu_a, cov_a, 'r');
plotClusters(mu_b, cov_b, 'b');

contour(X1, Y1, nn_ab, 'Color', 'g');
contour(X1, Y1, knn_ab, 'Color', 'k');

title('NN, 5NN Classifications of A and B')
legend('Class A', 'Class B', 'Unit SD Contour A', 'Unit SD Contour B', 'NN', '5NN')
xlabel('x'); ylabel('y');
hold off;


% Plotting NN, 5NN decision boundaries for Case 2
nn_cde = knn(1, {clusterC, clusterD, clusterE}, X1, Y1);
knn_cde = knn(5, {clusterC, clusterD, clusterE}, X1, Y1);
figure(6)
hold on;
samplesC = scatter(clusterC(:,1), clusterC(:,2), scatterSize, 'r', 'filled');
samplesD = scatter(clusterD(:,1), clusterD(:,2), scatterSize, 'b', 'filled');
samplesE = scatter(clusterE(:,1), clusterE(:,2), scatterSize, 'm', 'filled');

plotClusters(mu_c, cov_c, 'r');
plotClusters(mu_d, cov_d, 'b');
plotClusters(mu_e, cov_e, 'm');

contour(X2, Y2, nn_cde, 'Color', 'g');
contour(X2, Y2, knn_cde, 'Color', 'k');

title('NN, 5NN Classifications of C, D, and E')
legend('Class C', 'Class D', 'Class E', 'Unit SD Contour C', 'Unit SD Contour D', 'Unit SD Contour E', 'NN', '5NN')
xlabel('x'); ylabel('y');
hold off;


%% 
% ERROR ANALYSIS FOR MED
[trueA, falseAasB] = classifyClusterForCase1(clusterA, mu_a', mu_b');
[trueB, falseBasA] = classifyClusterForCase1(clusterB, mu_b', mu_a');

[medCM_A, medCM_B] = createConfusionMatrixCase1(trueA, falseAasB, trueB, falseBasA);

disp("Confusion Matrix for A");
disp(medCM_A);

disp("Confusion Matrix for B");
disp(medCM_B);

probErrorMEDCase1 = (falseAasB + falseBasA) / (N_a + N_b);
disp("Probability of error for MED Case 1 = " + probErrorMEDCase1); 

[trueC, falseCasD, falseCasE] = classifyClusterForCase2(clusterC, mu_c', mu_d', mu_e');
[trueD, falseDasC, falseDasE] = classifyClusterForCase2(clusterD, mu_d', mu_c', mu_e');
[trueE, falseEasC, falseEasD] = classifyClusterForCase2(clusterE, mu_e', mu_c', mu_d');
[medCM_C, medCM_D, medCM_E] = createConfusionMatrixCase2(trueC, falseCasD, falseCasE,...
                                                        trueD, falseDasC, falseDasE,...
                                                        trueE, falseEasC, falseEasD);                                              
disp("Confusion Matrix for C");
disp(medCM_C);

disp("Confusion Matrix for D");
disp(medCM_D);

disp("Confusion Matrix for E");
disp(medCM_E);

probErrorMEDCase2 = (falseCasD + falseCasE + falseDasC + falseDasE + falseEasC + falseEasD) / (N_c + N_d + N_e);
disp("Probability of error for MED Case 2 = " + probErrorMEDCase2); 
