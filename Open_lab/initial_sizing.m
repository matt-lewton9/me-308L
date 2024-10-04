G14_data = readmatrix("G_14_sample_data.xlsx");

%% Test Conditions
alphas_deg = 0:10:40; % deg
alphas = deg2rad(alphas_deg);
Umax = 44.8; % m/s
rho = 1.225; % kg/m3, STP density

Q = 0.5*rho*Umax^2;

%% Fin Geometry
l = 0.1016; % m
w = l*(2.18/2.74); % m, porportional to L in G14
h = l*(.384/2.74); % m, porportional to L in G14
t = l*(0.008/2.74); % m, porportional to L in G14
spacing = l*(0.371/2.74); % m
FREEDOM_UNITS = [l*39.37, w*39.37, h*39.37, t*39.37]
D_body = l*(5/2.74); % m, Arbitrary rocket diameter scaled proportionally

S_A = w*h; % Ref area of side section
S_N = D_body^2 * pi/4; % Ref area of relative rocket OD Scaled

%% Forces
N = S_N*Q.*G14_data(:,2)'; % N
A = S_A*Q.*G14_data(:,2)'; % N

L = N.*cos(alphas) + A.*sin(alphas);
D = A.*cos(alphas) + L.*sin(alphas);

figure(1)
plot(alphas_deg, L);
hold on
plot(alphas_deg, D);
hold on
plot(alphas_deg,N)
hold on
plot(alphas_deg, A)
xlabel("Angle of Attack (deg)")
ylabel("Force (N)")
legend("Lift", "Drag","Normal", 'Axial', 'location', 'best')
