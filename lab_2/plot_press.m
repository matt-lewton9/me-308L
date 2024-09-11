function plot_press(pos, n, dynam_pres)
 figure(n);   
    errorbar(pos(:,5), pos(:,3), 2*pos(:,7),'horizontal')
    hold on
    errorbar(pos(:,6), pos(:,3), 2*pos(:,8), 'horizontal')
    legend(["Stagnation Pressure P_0", "Static Pressure P_s"], "Location","southeast")
    
    set(gcf,'outerposition',0.3.*[0 0 3000 2500])

    ax1 = gca;
    xlabel(ax1,'P (Pa)')
    ylabel(ax1,'y (mm)')
    grid on

    ax2 = axes('Position',ax1.Position,'XAxisLocation','top','YAxisLocation','right', 'Color', 'none');
  
    xlabel(ax2,"P/({\rho}1/2V^2)")
    ylabel(ax2,"y/D")
    ax1.Box = 'off';
    ax2.Box = 'off';
    
    xlim(ax2, [min(pos(:,5))/dynam_pres max(pos(:,5))/dynam_pres])
    ylim(ax2, [(abs(pos(1,3)))/50.799999 (abs(pos(end,3)))/50.799999])
    
    saveas(gcf, sprintf("pos%dpress.png", n))
end