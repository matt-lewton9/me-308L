clc;
clear;

%% Globals
% Setup Dimensions
ID = 25.4/1000; % m
A = pi*(ID^2)/4; %m^2
l = 0.476;
g = 9.81; % m/s2
dz = 0.2286; % m

% Fluid Constants
rho = 998.19; % kg/m^3
v = 1.14E-06; % m^2/s, kinematic viscosity

% Load data
data = readmatrix("Team4_Lab5_MajorLoss.xlsx");
Q = data(:,1) .* 0.00006309019640344; % m^3 / s
P2 = data(:,4).* 	6894.7572931783; % Pa
P1 = data(:,3).* 	6894.7572931783; % Pa

dP = P2 - P1;

Hp = (dP ./ rho./g) + (dz);

ind = ([100 197 298 401 498 599 701 799 898 999 1101])-1;
prev = 1;

for i = 1:11
     Hp_avg(i) = mean(Hp(prev:ind(i)));
     Hp_std(i) = std(Hp(prev:ind(i)));
     Q_avg(i) = mean(Q(prev:ind(i)));
     
     Up1(i) = std(P1(prev:ind(i)));
     Up2(i) = std(P2(prev:ind(i)));
     
     P1_avg(i) = mean(P1(prev:ind(i)));
     P2_avg(i) = mean(P2(prev:ind(i)));
     
     prev = ind(i)+1;
end

U = sqrt(((2.*Up1./rho./g).^2) + ((2.*Up2./rho./g).^2));


P = polyfit(Q_avg.^2, Hp_avg, 1);
f = polyval([P(1), 0, P(2)], Q);
disp(P(1))
disp(P(2))

% plot(Q, Hp, 'o')
hold on
% errorbar(Q_avg, Hp_avg, 2.*Hp_std)
hold on
errorbar(Q_avg, Hp_avg, U)
hold on
plot(Q, f, '--')
xlabel("Volumetric Flowrate, [m^3/s]")
ylabel("Pump Head [m]")
legend("Experimental Data", "Curve Fit", "Location",'best')

