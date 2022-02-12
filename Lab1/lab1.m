clc;
close all;
clear;

% Defining the five classes of data
N_a=200; mu_a = [5 10]; cov_a = [8 0; 0 4];
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

% Plotting the samples and unit standard deviation countour for classes A and B
figure(1)
scatterSize = 15;
hold on
samplesA = scatter(clusterA(:,1), clusterA(:,2), scatterSize, 'r', 'filled');
plotClusters(mu_a, cov_a, 'r');

samplesB = scatter(clusterB(:,1), clusterB(:,2), scatterSize, 'b', 'filled');
plotClusters(mu_b, cov_b, 'b');
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
hold off
