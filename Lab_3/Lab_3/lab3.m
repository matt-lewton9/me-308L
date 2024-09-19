clc;
clear;

%Load data
TS_Data = readmatrix("Test_Stand_Only/Test_Stand_Summary.xlsx");
SS_Data = readmatrix("Small_Sphere/Small_Sphere_Summary.xlsx");
MS_Data = readmatrix("Medium_Sphere/Medium_Sphere_Summary.xlsx");
LS_Data = readmatrix("Large_Sphere/Large_Sphere_Summary.xlsx");


TS = zeros(8, 10);
SS = zeros(8, 10);
MS = zeros(8, 10);
LS = zeros(8, 10);


for i= 1:8
HZ = [0 30:5:60];
lifts = 2:3:100;
drags = 3:3:100;

%% [     1            2             3              4             5           6         7            8         9   10
%% [ Speed [Hz], Lift Mean[V], Drag Mean [V], Lift STD [V], Drag STD [V], Lift [N], Drag [N], Velocity [m/s], Re, Cd ]

TS(i, 1:5) = [HZ(i), mean(TS_Data(:,lifts(i))), mean(TS_Data(:,drags(i))), std(TS_Data(:,lifts(i))), std(TS_Data(:,drags(i)))];
SS(i, 1:5) = [HZ(i), mean(SS_Data(:,lifts(i))), mean(SS_Data(:,drags(i))), std(SS_Data(:,lifts(i))), std(SS_Data(:,drags(i)))];
LS(i, 1:5) = [HZ(i), mean(LS_Data(:,lifts(i))), mean(LS_Data(:,drags(i))), std(LS_Data(:,lifts(i))), std(LS_Data(:,drags(i)))];
try
    MS(i, 1:5) = [HZ(i), mean(MS_Data(:,lifts(i))), mean(MS_Data(:,drags(i))), std(MS_Data(:,lifts(i))), std(MS_Data(:,drags(i)))];
end

end
MS(3:4,:) = MS(2:3,:); % Put rows in correct position with respect to TS data
MS(3:4, 1) = [35;40]; % Correct MS Speeds
MS(2,:) = 0.*MS(2,:); %Set 30 HZ data to zero

K_lift = 82.076;
K_drag = 11.27;

% Lift
SS(:,6) = K_lift .*( (SS(:,2) - SS(1,2)) - ((TS(:,2))-TS(1,2)) ); %% SS lift [N]
MS(:,6) = K_lift .*( (MS(:,2) - MS(1,2)) - ((TS(:,2))-TS(1,2)) ); %% MS lift [N]
LS(:,6) = K_lift .*( (LS(:,2) - LS(1,2)) - ((TS(:,2))-TS(1,2)) ); %% LS lift [N]

% Drag
SS(:,7) = K_drag .*( (SS(:,3) - SS(1,3)) - ((TS(:,3))-TS(1,3)) ); %% SS Drag [N]
MS(:,7) = K_drag .*( (MS(:,3) - MS(1,3)) - ((TS(:,3))-TS(1,3)) ); %% SS Drag [N]
LS(:,7) = K_drag .*( (LS(:,3) - LS(1,3)) - ((TS(:,3))-TS(1,3)) ); %% SS Drag [N]

% Velocity
SS(2:end, 8) = (SS(2:end,1) .* 0.81123) -2.6419; % Hz to velocity [m/s]
MS(2:end, 8) = (MS(2:end,1) .* 0.81123) -2.6419; % Hz to velocity [m/s]
LS(2:end, 8) = (LS(2:end,1) .* 0.81123) -2.6419; % Hz to velocity [m/s]

% Reynold's Number
rho = 1.18; % density [kg/m^3]
visco = 1.48e-05; %  Bulk Viscosity [Pa-s]
Dia_SS = 0.0635; % [m]
Dia_MS = 0.0762; % [m]
Dia_LS = 0.1016; % [m]

SS(:, 9) = Dia_SS .* rho .* SS(:,8) ./ visco; % Re SS 
MS(:, 9) = Dia_MS .* rho .* MS(:,8) ./ visco; % Re MS
LS(:, 9) = Dia_LS .* rho .* LS(:,8) ./ visco; % Re LS 

SS(2:end, 10) = 2.* SS(2:end, 7) ./ ( (SS(2:end, 8).^2) .* rho .* pi() .* (Dia_SS^2) ./ 4); % Cd SS
MS(2:end, 10) = 2.* MS(2:end, 7) ./ ( (MS(2:end, 8).^2) .* rho .* pi() .* (Dia_MS^2) ./ 4); % Cd MS
LS(2:end, 10) = 2.* LS(2:end, 7) ./ ( (LS(2:end, 8).^2) .* rho .* pi() .* (Dia_LS^2) ./ 4); % Cd LS

% Uncertainty:
U_v = 1 * 0.81123;

A_SS = pi()*(Dia_SS^2)/4; % lol Area SS
A_MS = pi()*(Dia_MS^2)/4; % Area MS
A_LS = pi()*(Dia_LS^2)/4; % Area MS

U_SS = sqrt( ((2* SS(2:end, 5) .* K_drag) .* 2 ./ (rho .* A_SS .* (SS(2:end, 8).^2))).^2 + (U_v .* 4 .* SS(2:end, 7)./rho./(SS(2:end, 8).^3)./A_SS).^2);
U_MS = sqrt( ((2* MS(2:end, 5) .* K_drag) .* 2 ./ (rho .* A_MS .* (MS(2:end, 8).^2))).^2 + (U_v .* 4 .* MS(2:end, 7)./rho./(MS(2:end, 8).^3)./A_MS).^2);
U_LS = sqrt( ((2* LS(2:end, 5) .* K_drag) .* 2 ./ (rho .* A_LS .* (LS(2:end, 8).^2))).^2 + (U_v .* 4 .* LS(2:end, 7)./rho./(LS(2:end, 8).^3)./A_LS).^2);

% Emperical CD/Re
Re_emp = linspace(110000,370000, 8);
Cd_emp = [0.503 0.504 0.500 0.495 0.488 0.482 0.473 0.288];

figure(1)
    errorbar(SS(2:end,9), SS(2:end,10), U_SS, 'o')
    hold on
    %errorbar(MS(3:4,9), MS(3:4,10), U_MS(2:3, :),'o')
    hold on
    errorbar(LS(2:end,9), LS(2:end,10), U_LS,'o')
    hold on
    plot(Re_emp, Cd_emp)

    legend("Small Sphere", "Large Sphere", "Emperical Coefficients ", 'Location', 'southwest')
    ylabel("Drag Coefficient")
    xlabel("Reynold's Number")

