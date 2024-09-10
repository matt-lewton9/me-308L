data = readmatrix("cleaned_data.csv");

%air density
Pstatic = 99719; % Pa
Temp = 21+273.15; % K
R = 287; % J/kg-K
rho = Pstatic / Temp / R; %kg/m^3

%reynold's number
V = 24.8; % m/s
d = 50.8/1000; % m
kinem_visc= 1.48e-5; %m^2/s 
dynam_pres = rho*(V^2)/2; % m/s
Re = V*d*rho/kinem_visc;

pos1 = data(1:11,:);
pos2 = data(12:23,:);
pos3 = data(24:29,:);
pos4 = data(32:39,:);
pos5 = data(40:49,:);

figure(1)
    plot(pos1(:,5), pos1(:,3))
    hold on
    plot(pos1(:,6), pos1(:,3))

 
    ylabel("y (mm)")
    yyaxis right
    ylim([0, (pos1(1,3))/50.8]);
    ylabel("y/D")

    legend(["Stagnation Pressure", "Static Pressure"], "Location","southeast")


    xlabel("P (Pa)")
    ax2 = axes('XAxisLocation','top','Color','none', 'XColor','k');
    ax2.YAxis.Visible = 'off';
    xlim([0, max(pos1(:,5))/dynam_pres])

% figure(2)
%     plot(pos2(:,5), pos2(:,3))
%     hold on
%     plot(pos2(:,6), pos2(:,3))
% 
% figure(3)
%     plot(pos3(:,5), pos3(:,3))
%     hold on
%     plot(pos3(:,6), pos3(:,3))
% 
% figure(4)
%     plot(pos4(:,5), pos4(:,3))
%     hold on
%     plot(pos4(:,6), pos4(:,3))
% 
% figure(5)
%     plot(pos5(:,5), pos5(:,3))
%     hold on
%     plot(pos5(:,6), pos5(:,3))