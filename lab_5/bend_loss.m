function bend_loss(P1, P2, V, N)
    %% Constants
    rho = 998.19; % kg/m^3
    v = 1.14E-06; % m^2/s, kinematic viscosity
    ID = 25.4/1000; % m

    Re = V .*ID ./v;
    
    % Method 1
    hl1 = (P1-P2)./ rho;
    K1 = 2 .* hl1 ./ (V.^2);

    % Method 2
    dP_A = mean(P2(1:100) - P1(1:100));
    V_A = mean(V(1:100));
    dP_B = P2(101:end) - P1(101:end);
    V_B = V(101:end);

    K2 = 2 .* (dP_B - dP_A) ./((V_A^2) - (V_B.^2)) ./ rho;

    Ktheoretical = 1.3 .* ones(numel(Re),1);

    ind = [100 200 401 498 597 701 800 898 999 1097];
    prev = 1;
    for i = 1:10
         K1_avg(i) = mean(K1(prev:ind(i)));
         K1_std(i) = std(K1(prev:ind(i)));
         Re_avg(i) = mean(Re(prev:ind(i)));
         prev = ind(i)+1;
    end

    ind2 = ([200 401 498 597 701 800 898 999 1097]-100);
    prev = 1;
    for i = 1:9
         K2_avg(i) = mean(K2(prev:ind2(i)));
         K2_std(i) = std(K2(prev:ind2(i)));
         Re2_avg(i) = mean(Re(prev:ind2(i)));
         prev = ind(i);
    end

disp(mean(K2))

    fig = figure(N);
    subplot(2,1,1)
        errorbar(Re_avg, K1_avg, 2.*K1_std, 'o')
        hold on
        plot(Re, Ktheoretical, '--')
        hold on
%         plot(Re, K1, 'o')
        legend("Experimental Data", "Emperical Value", 'location', 'best')
        title("Method 1, Loss Coefficient K vs Re")
        xlabel("Reynold's Number")
        ylabel("Loss Coefficient, K")

    subplot(2,1,2)
        errorbar(Re2_avg, K2_avg, 2.*K2_std, 'o')
        hold on
        plot(Re, Ktheoretical, '--')
        hold on
%         plot(Re(101:end), K2, 'o')
        legend("Experimental Data", "Emperical Value", 'location', 'best')
        title("Method 2, Loss Coefficient K vs Re")
        xlabel("Reynold's Number")
        ylabel("Loss Coefficient, K")

%         saveas(fig, sprintf("bend_%d", N),'png')


end