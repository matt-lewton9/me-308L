clc;
clear;

% Load data
data = readmatrix("Team4_Lab5_MajorLoss.xlsx");
Q = data(:,1) .* 0.00006309019640344; % m^3 / s
dP = data(:,2).* 	6894.7572931783; % Pa

% Setup Dimensions
ID = 25.4/1000; % m
l = 2.63; % m
e = 0.002/1000;

% Fluid Constants
rho = 999; % kg/m^3
v = 1.14E-06; % m^2/s, kinematic viscosity
mu = 1.14E-03;

% Calcs
A = pi*(ID^2)/4; %m^2
V = Q ./ A; % m/s
Re =  ID .* V ./ v; % Re

hl = dP./rho;

f = hl .* (2*ID/l ./(V.^2));

f_theoretical = 1./((-1.8.*log10(((e/ID/3.7)^1.11) + (6.9./Re))).^2);

ind = ([100 197 298 401 498 599 701 799 898 999 1101])-1;
prev = 1;

for i = 1:11
     f_avg(i) = mean(f(prev:ind(i)));
     f_std(i) = std(f(prev:ind(i)));
     Re_avg(i) = mean(Re(prev:ind(i)));
     prev = ind(i)+1;
end

figure(1)
%     plot(Re, f, 'o')
    hold on
    errorbar(Re_avg, f_avg, 2*f_std)

    hold on
    plot(Re, f_theoretical, '--')
    xlabel("Reynold's Number")
    ylabel("Friction Factor, f")
    legend("Experimental Data", "Theoretical Curve", 'location', 'best')
    title("Friction Factor vs Reynold's Number")