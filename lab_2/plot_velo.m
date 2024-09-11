function plot_velo(pos, n, rho, Vfree)

velo = sqrt(2.*abs(pos(:,5) - pos(:,6))./rho);

dVdP0 = 1./sqrt(2.*abs(pos(:,5) - pos(:,6)))./sqrt(rho);
dVdPs = dVdP0;
U = sqrt(((dVdP0 .* 2.*pos(:,7)).^2) + ((dVdPs .* 2.*pos(:,8)).^2));

figure(n);   
    errorbar(velo, pos(:,3), U, 'horizontal');
    
    set(gcf,'outerposition',0.3.*[0 0 3000 2500])

    ax1 = gca;
    xlabel(ax1,'V (m/s)')
    ylabel(ax1,'y (mm)')
    grid on

    ax2 = axes('Position',ax1.Position,'XAxisLocation','top','YAxisLocation','right', 'Color', 'none');
  
    xlabel(ax2,"V/V_f")
    ylabel(ax2,"y/D")
    ax1.Box = 'off';
    ax2.Box = 'off';
    
    xlim(ax2, [min(velo)/Vfree max(velo)/Vfree])
    ylim(ax2, [(abs(pos(1,3)))/50.799999 (abs(pos(end,3)))/50.799999])
    
    saveas(gcf, sprintf("pos%dvelo.png", n))
    
disp(mean(velo))
end