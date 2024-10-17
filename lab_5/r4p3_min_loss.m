clc;
clear;

%% Globals
% Setup Dimensions
ID = 25.4/1000; % m
A = pi*(ID^2)/4; %m^2
l = 0.476;
f = 0.035;

% Fluid Constants
rho = 998.19; % kg/m^3
v = 1.14E-06; % m^2/s, kinematic viscosity

%% Setup 1 1/3 closed
% Load data
data = readmatrix("Team4_Lab5_Bend.xlsx");
Q = data(:,5).* 0.000063090196666667; % m^3 / s
P1 = data(:,7).* 6894.7572931783; % Pa
P2 = data(:,8).* 6894.7572931783; % Pa
P3 = data(:,9).* 6894.7572931783; % Pa
P4 = data(:,10).* 6894.7572931783; % Pa
P5 = data(:,11).* 6894.7572931783; % Pa

V = Q ./A;

bend_loss(P1, P2, V, 1);
bend_loss(P2, P3, V, 2);
bend_loss(P3, P4, V, 3);
bend_loss(P4, P5, V, 4);