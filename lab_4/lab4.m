clc;
clear;

data = readmatrix("team4_lab4.xlsx");

%% [ 1: X, 2:Y, 3:u, 4:v, 5:rho, 6:Po, 7:Ps)
AB = data(1:9, [2 3 5 6 10 11 12]);
BC = data(9:31, [2 3 5 6 10 11 12]);
CD = data(31:end, [2 3 5 6 10 11 12]);

Pamb = 100788;
Q = 0.5 * mean(AB(:,5) * (mean(AB(:,3))^2));

pForceAB = trapz(AB(:,2)./1000,AB(:,7)-Pamb);

pForceCD = -trapz(CD(:,2)./1000,CD(:,7)-Pamb);

mForceAB = trapz(AB(:,2)./1000, AB(:,5) .*AB(:,3).*AB(:,3));
mForceCD = -trapz(CD(:,2)./1000, CD(:,5) .*CD(:,3).*CD(:,3));

Rx = mForceAB - mForceCD - pForceAB + pForceCD;

Cd = -Rx / Q /(0.0254);

Re = mean(AB(:,3)) *2* 0.0254/(1.516e-5);

%% Velocity Plots
figure(1)
    plot(AB(:,2), AB(:,3))
    hold on
    plot(AB(:,2), AB(:,4))
    title("Surface AB")
    ylabel("Velocity [m/s]")
    xlabel("Y position [mm]")
    legend("u: x-velocity", "v: y-velocity", 'Location','best')
    %ylim([15 28]);

figure(2)
    plot(BC(:,1), BC(:,3))
    hold on    
    plot(BC(:,1), BC(:,4))
    title("Surface BC Velocity")
    ylabel("Velocity [m/s]")
    legend("u: x-velocity", "v: y-velocity", 'Location','best')
    xlabel("X position [mm]")

figure(3)
    plot(CD(:,2), CD(:,3))
    hold on
    plot(CD(:,2), CD(:,4))
    title("Surface CD Velocity")
    ylabel("Velocity [m/s]")
    xlabel("Y position [mm]")
    legend("u: x-velocity", "v: y-velocity", 'Location','best')

%% Pressure Plots
figure(4)
    plot(AB(:,2), AB(:,6))
    hold on 
    plot(AB(:,2), AB(:,7))
    title("Surface AB Pressure")
    ylabel("Pressure [Pa]")
    xlabel("Y position [mm]")
    legend("Stagnation Pressure", "Static Pressure", 'Location', 'best')
    

figure(5)
    plot(BC(:,1), BC(:,6))
    hold on
    plot(BC(:,1), BC(:,7))
    title("Surface BC Pressure")
    ylabel("Pressure [Pa]")
    xlabel("X position [mm]")
    legend("Stagnation Pressure", "Static Pressure", 'Location', 'best')

figure(6)
    plot(CD(:,2), CD(:,6))
    hold on
    plot(CD(:,2), CD(:,7))
    title("Surface CD Pressure")
    ylabel("Pressure [Pa]")
    xlabel("Y position [mm]")
    legend("Stagnation Pressure", "Static Pressure", 'Location', 'best')

