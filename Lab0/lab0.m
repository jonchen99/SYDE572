% SYDE Lab 0 - Matlab Introduction
% Name: Jonathan Chen Date: Jan 9, 2022

clc
clear all % clear all variables from memory
close all % close all open figures

% define the mean and variance of the pdf
mu = [0 0]';
sigma = [1 0; 0 1];

dx = 0.1; % step-size
x1 = [-3:dx:3]; % range of the random variable x1
x2 = [-3:dx:3]; % range of the random variable x2

% this calls the function we create
y = Gauss2d(x1,x2,mu,sigma);

disp("Est. Integral: ");
disp(sum(y(:))*(x1(2)-x1(1))*(x2(2)-x2(1)));
% Show a 3-D plot of the pdf
figure
subplot(2,1,1);
surf(x1,x2,y);
xlabel('x_2');
ylabel('x_1');
zlabel('p(x_1,x_2)');
colormap('jet');

% Show contours of the pdf
subplot (2,1,2);
contour(x1,x2,y);
ylabel('x_{1}');
xlabel('x_{2}');
axis equal

% Show a colour map of the pdf
figure
imagesc(x1,x2,y)
ylabel('x_{1}');
xlabel('x_{2}');
colormap('jet');
colorbar();
set(gca, 'YDir', 'normal');

z = (y>0.1);
figure
imagesc(x1,x2,z)
hold on % allow us to plot more on the same figure
plot(mu(1,1), mu(2,1), 'y.'); % plot the mean
ylabel('x_{1}');
xlabel('x_{2}');
colormap('gray');
colorbar();
set(gca, 'YDir', 'normal');