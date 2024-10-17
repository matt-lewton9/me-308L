clc;
clear;

%% Globals
% Setup Dimensions
ID = 2*25.4/1000; % m
A = pi*(ID^2)/4; %m^2
l = 0.476;
f = 0.035;

% Fluid Constants
rho = 998.19; % kg/m^3
v = 1.14E-06; % m^2/s, kinematic viscosity

%% Setup 1 1/3 closed
% Load data
data1 = readmatrix("Team4_Lab5_Valve1.xlsx");
Q1 = data1(:,12).* 0.000063090196666667; % m^3 / s
dP1 = data1(:,13).* 6894.7572931783; % Pa

V1 = Q1 ./ A; % m/s
Re1 =  ID .* V1 ./ v; % Re

majloss1 = (V1.^2).* f .* l ./ ID ./ 2;

hl1 = dP1./rho -majloss1;
K1 = 2.*hl1./(V1.^2);
K_theoretical1 = 5.5.* ones(1,numel(Re1));

ind1 = [99 198 299 400 502 601];
prev1 = 1;
for i = 1:6
     K_avg1(i) = mean(K1(prev1:ind1(i)));
     K_std1(i) = std(K1(prev1:ind1(i)));
     Re_avg1(i) = mean(Re1(prev1:ind1(i)));
     prev1 = ind1(i)+1;
end


%% Setup 2 1/2 closed
% Load data
data2 = readmatrix("Team4_Lab5_Valve2.xlsx");
Q2 = data2(:,12) .* 0.00006309019640344; % m^3 / s
dP2 = data2(:,13).* 	6894.7572931783; % Pa

% Calcs
V2 = Q2 ./ A; % m/s
Re2 =  ID .* V2 ./ v; % Re

majloss2 = (V2.^2).* f * l / ID / 2;

hl2 = dP2./rho - majloss2;
K2 = 2.*hl2./(V2.^2);
K_theoretical2 = 5.5.* ones(1,numel(Re2));

ind2 = [98 200 300 400 497 600];
prev2 = 1;
for i = 1:6
     K_avg2(i) = mean(K2(prev2:ind2(i)));
     K_std2(i) = std(K2(prev2:ind2(i)));
     Re_avg2(i) = mean(Re2(prev2:ind2(i)));
     prev2 = ind2(i)+1;
end


figure(1)
    hold on
    errorbar(Re_avg1, K_avg1, 2*K_std1)
    hold on
   errorbar(Re_avg2, K_avg2, 2*K_std2)
    hold on
    plot(Re1, K_theoretical1, '--')
    hold on

    xlabel("Reynold's Number")
    ylabel("Loss Coefficient, K")
    legend("Experimental Data 1/3 closed", "Experimental Data 1/2 Closed", "Emperical Curve 1/3 Closed", 'location', 'best')
    title("Loss Coefficient vs Reynold's Number")