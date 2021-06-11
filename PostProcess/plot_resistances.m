function plot_resistances(Case)

hR = figure(61);
CPP = [40 ,60, 80, 100, 120, 140];

axes('position',[0.15 0.15 0.75 0.75]); hold on;
p1 = plot(CPP,Case.RAepi/Case.RAmid(4),'b-','linewidth',1.5);
p2 = plot(CPP,Case.RAmid/Case.RAmid(4),'-','linewidth',1.5,'Color',[0.0 4 0.0]/8);
p3 = plot(CPP,Case.RAendo/Case.RAmid(4),'r-','linewidth',1.5);

set(gca,'Fontsize',14); box on
ylabel('R/R0','interpreter','latex','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
legend([p1, p2, p3], 'Epi.','Mid.','Endo.','Location','best');
saveas(hR, [Case.name,'R.png']);

close all;
fclose all;
movefile('*.png',['./Figs/',Case.name]);

end