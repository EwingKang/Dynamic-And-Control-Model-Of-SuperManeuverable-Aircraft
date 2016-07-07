a_abs = 0:90;
for i = 1:10
    style = 'Even';
    if (X31_initP.fig2_2(i).a(8) ==1)
        style = 'Odd';
    end
    fig_name = sprintf('Figure 2.2.%da %s',i,style);
    figure('name',fig_name)
    plot(a_abs,X31_initP.fig2_2(i).a(6).*a_abs.^6 + X31_initP.fig2_2(i).a(5).*a_abs.^5 + X31_initP.fig2_2(i).a(4).*a_abs.^4 +X31_initP.fig2_2(i).a(3).*a_abs.^3 + X31_initP.fig2_2(i).a(2).*a_abs.^2 + X31_initP.fig2_2(i).a(1).*a_abs + X31_initP.fig2_2(i).a(7));    
    grid on;
    
    style = 'Even';
    if (X31_initP.fig2_2(i).b(8) ==1)
        style = 'Odd';
    end
    fig_name = sprintf('Figure 2.2.%db %s',i,style);
    figure('name',fig_name)
    plot(a_abs,X31_initP.fig2_2(i).b(6).*a_abs.^6 + X31_initP.fig2_2(i).b(5).*a_abs.^5 + X31_initP.fig2_2(i).b(4).*a_abs.^4 +X31_initP.fig2_2(i).b(3).*a_abs.^3 + X31_initP.fig2_2(i).b(2).*a_abs.^2 + X31_initP.fig2_2(i).b(1).*a_abs + X31_initP.fig2_2(i).b(7));
    grid on;
end

clearvars a_abs style fig_name