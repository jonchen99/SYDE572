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
med_ab = classifyGrid(X1, Y1, @(points) med([mu_a; mu_b], points));
micd_ab = classifyGrid(X1, Y1, @(points) micd(mu_a, mu_b, cov_a, cov_b, X1, Y1));
map_ab = classifyGrid(X1, Y1, @(points) map(mu_a, mu_b, cov_a, cov_b, N_a, N_b, X1, Y1));
figure(3)
hold on;
samplesA = scatter(clusterA(:,1), clusterA(:,2), scatterSize, 'r', 'filled');
samplesB = scatter(clusterB(:,1), clusterB(:,2), scatterSize, 'b', 'filled');
plotClusters(mu_a, cov_a, 'r');
plotClusters(mu_b, cov_b, 'b');

contour(X1, Y1, med_ab, 'Color', 'g');
contour(X1, Y1, micd_ab, 'Color', 'c');
contour(X1, Y1, map_ab, 'Color', 'b');
% TODO ADD CLASSIFIERS FOR MAP BOUNDARIES

title('MED, MICD, and MAP Classifications of A and B')
legend('Class A', 'Class B', 'Unit SD Contour A', 'Unit SD Contour B', 'MED', 'MICD')
xlabel('x'); ylabel('y');
hold off;


% Plotting MED, MICD, MAP decision boundaries for Case 2
med_cde = classifyGrid(X2, Y2, @(points) med([mu_c; mu_d; mu_e], points));
micd_cde = classifyGrid(X2, Y2, @(points) micd3(mu_c, mu_d, mu_e, cov_c, cov_d, cov_e, X2, Y2));
map_cde = classifyGrid(X2, Y2, @(points) map3(mu_c, mu_d, mu_e, cov_c, cov_d, cov_e, N_c, N_d, N_e,X2, Y2));
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
contour(X2, Y2, map_cde, 'Color', 'b');

title('MED, MICD, and MAP Classifications of C, D, and E')
legend('Class C', 'Class D', 'Class E', 'Unit SD Contour C', 'Unit SD Contour D', 'Unit SD Contour E','MED', 'MICD')
xlabel('x'); ylabel('y');
hold off;

%%

% Plotting NN, 5NN decision boundaries for Case 1
nn_ab = classifyGrid(X1, Y1, @(points) knn(1, {clusterA, clusterB}, points));
knn_ab = classifyGrid(X1, Y1, @(points) knn(5, {clusterA, clusterB}, points));
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
nn_cde = classifyGrid(X2, Y2, @(points) knn(1, {clusterC, clusterD, clusterE}, points));
knn_cde = classifyGrid(X2, Y2, @(points) knn(5, {clusterC, clusterD, clusterE}, points));
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
C_AB = createConfusionMatrix({clusterA, clusterB}, @(points) med([mu_a; mu_b], points));

disp("Confusion Matrix for A, B");
disp(C_AB);
disp("Probability of error for MED Case 1 = " + getErrorRate(C_AB));

C_CDE = createConfusionMatrix({clusterC, clusterD, clusterE}, @(points) med([mu_c; mu_d; mu_e], points));
                                          
disp("Confusion Matrix for C, D, E");
disp(C_CDE);
disp("Probability of error for MED Case 2 = " + getErrorRate(C_CDE));

%% 
% ERROR ANALYSIS FOR MICD
C_AB = createConfusionMatrix({clusterA, clusterB}, @(points) micd(mu_a, mu_b, cov_a, cov_b, X1, Y1));

disp("Confusion Matrix for A, B");
disp(C_AB);
disp("Probability of error for MICD Case 1 = " + getErrorRate(C_AB));

C_CDE = createConfusionMatrix({clusterC, clusterD, clusterE}, @(points) micd3(mu_c, mu_d, mu_e, cov_c, cov_d, cov_e, X2, Y2));
                                          
disp("Confusion Matrix for C, D, E");
disp(C_CDE);
disp("Probability of error for MICD Case 2 = " + getErrorRate(C_CDE));

%% 
% ERROR ANALYSIS FOR MAP
C_AB = createConfusionMatrix({clusterA, clusterB}, @(points) map(mu_a, mu_b, cov_a, cov_b, N_a, N_b, X1, Y1));

disp("Confusion Matrix for A, B");
disp(C_AB);
disp("Probability of error for MAP Case 1 = " + getErrorRate(C_AB));

C_CDE = createConfusionMatrix({clusterC, clusterD, clusterE}, @(points) map3(mu_c, mu_d, mu_e, cov_c, cov_d, cov_e, N_c, N_d, N_e, X1, Y1));
                                          
disp("Confusion Matrix for C, D, E");
disp(C_CDE);
disp("Probability of error for MAP Case 2 = " + getErrorRate(C_CDE));


%% 
% ERROR ANALYSIS FOR NN
testClusterA = generateBivariateCluster(N_a, mu_a, cov_a);
testClusterB = generateBivariateCluster(N_b, mu_b, cov_b);

C_AB = createConfusionMatrix({testClusterA, testClusterB}, ...
    @(points) knn(1, {clusterA, clusterB}, points));

disp("Confusion Matrix for A, B");
disp(C_AB);
disp("Probability of error for NN Case 1 = " + getErrorRate(C_AB));

testClusterC = generateBivariateCluster(N_c, mu_c, cov_c);
testClusterD = generateBivariateCluster(N_d, mu_d, cov_d);
testClusterE = generateBivariateCluster(N_e, mu_e, cov_e);

C_CDE = createConfusionMatrix({testClusterC, testClusterD, testClusterE}, ...
    @(points) knn(1, {clusterC, clusterD, clusterE}, points));
                                          
disp("Confusion Matrix for C, D, E");
disp(C_CDE);
disp("Probability of error for NN Case 2 = " + getErrorRate(C_CDE));


%% 
% ERROR ANALYSIS FOR 5NN
testClusterA = generateBivariateCluster(N_a, mu_a, cov_a);
testClusterB = generateBivariateCluster(N_b, mu_b, cov_b);

C_AB = createConfusionMatrix({testClusterA, testClusterB}, ...
    @(points) knn(5, {clusterA, clusterB}, points));

disp("Confusion Matrix for A, B");
disp(C_AB);
disp("Probability of error for 5NN Case 1 = " + getErrorRate(C_AB));

testClusterC = generateBivariateCluster(N_c, mu_c, cov_c);
testClusterD = generateBivariateCluster(N_d, mu_d, cov_d);
testClusterE = generateBivariateCluster(N_e, mu_e, cov_e);

C_CDE = createConfusionMatrix({testClusterC, testClusterD, testClusterE}, ...
    @(points) knn(5, {clusterC, clusterD, clusterE}, points));
                                          
disp("Confusion Matrix for C, D, E");
disp(C_CDE);
disp("Probability of error for 5NN Case 2 = " + getErrorRate(C_CDE));
