function Case = Evaluation_PZF_inf(Case)

%% Final Evualtion
[~, ~, Qmean_40, FlowAverage_40, h1_40, ~, T_40, ~, Pzf_40]   = pzf_inf( Case.gasol, Case.Testset(1), Case.t_final, Case.t_off);

disp(['Average flow: Experiment: ' num2str(FlowAverage_40)]);
disp(['Average flow: Simulation: ' num2str(Qmean_40)]);
saveas(h1_40, [Case.name,'P_inf_40.png']);


[~, ~, Qmean_60, FlowAverage_60, h1_60, ~, T_60, ~, Pzf_60]   = pzf_inf( Case.gasol, Case.Testset(2), Case.t_final, Case.t_off);

disp(['Average flow: Experiment: ' num2str(FlowAverage_60)]);
disp(['Average flow: Simulation: ' num2str(Qmean_60)]);
saveas(h1_60, [Case.name,'P_inf_60.png']);

[~, ~, Qmean_80, FlowAverage_80, h1_80, ~, T_80, ~, Pzf_80]   = pzf_inf( Case.gasol, Case.Testset(3), Case.t_final, Case.t_off);

disp(['Average flow: Experiment: ' num2str(FlowAverage_80)]);
disp(['Average flow: Simulation: ' num2str(Qmean_80)]);
saveas(h1_80, [Case.name,'P_inf_80.png']);

[~, ~, Qmean_100, FlowAverage_100, h1_100, ~, T_100, Params_100, Pzf_100]   = pzf_inf_BaseLine( Case.gasol, Case.Testset(4), Case.t_final, Case.t_off);

disp(['Average flow: Experiment: ' num2str(FlowAverage_100)]);
disp(['Average flow: Simulation: ' num2str(Qmean_100)]);
saveas(h1_100, [Case.name,'P_inf_100.png']);


[~, ~, Qmean_120, FlowAverage_120, h1_120, ~, T_120, ~, Pzf_120]   = pzf_inf( Case.gasol, Case.Testset(5), Case.t_final, Case.t_off);


disp(['Average flow: Experiment: ' num2str(FlowAverage_120)]);
disp(['Average flow: Simulation: ' num2str(Qmean_120)]);
saveas(h1_120, [Case.name,'P_inf_120.png']);

[~, ~, Qmean_140, FlowAverage_140, h1_140, ~, T_140, ~, Pzf_140]   = pzf_inf( Case.gasol, Case.Testset(6), Case.t_final, Case.t_off);

disp(['Average flow: Experiment: ' num2str(FlowAverage_140)]);
disp(['Average flow: Simulation: ' num2str(Qmean_140)]);
saveas(h1_140, [Case.name,'P_inf_140.png']);


%% Combined plots

CPP = [40 ,60, 80, 100, 120, 140];


%%
hT = figure(5);
Case.Tension = [T_40, T_60, T_80, T_100, T_120, T_140]/T_100;
axes('position',[0.15 0.15 0.75 0.75]); hold on;
plot(CPP,Case.Tension,'k-','linewidth',1.5);
set(gca,'Fontsize',14); box on
ylabel('T/T0','interpreter','latex','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);


%%
Case.Pzf_inf_mod = [Pzf_40(1), Pzf_60(1), Pzf_80(1), Pzf_100(1), Pzf_120(1), Pzf_140(1)];
Case.Pzf_exp = [Pzf_40(2), Pzf_60(2), Pzf_80(2), Pzf_100(2), Pzf_120(2), Pzf_140(2)];

hPzf = figure(7);
axes('position',[0.15 0.15 0.75 0.75]); hold on;
p1 = plot(CPP,Case.Pzf_inf_mod,'k-','linewidth',1.5);
p2 = scatter(CPP,Case.Pzf_exp,'ok','LineWidth',1.5);
ylabel('Pzf (mmHg)','interpreter','latex','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
set(gca,'Fontsize',14); box on
legend([p1, p2], 'Model','Experiment','Location','best');
saveas(hPzf, [Case.name,'Pzf_inf.png']);

%%
hTPzf = figure(8);
axes('position',[0.15 0.15 0.75 0.75]); hold on;
plot(Case.Tension,Case.Pzf_inf_mod,'ko','linewidth',1.5);
set(gca,'Fontsize',14); box on
legend('Model','Location','best');
hold on
f=fit(Case.Tension',Case.Pzf_inf_mod','poly1');
plot(f)
xlabel('T/T0','interpreter','latex','fontsize',16);
ylabel('Pzf (mmHg)','interpreter','latex','fontsize',16);
saveas(hTPzf, [Case.name,'T_Pzf_inf.png']);


fclose all;
movefile('*.png',['./Figs/',Case.name]);

Case.BaselineParams = Params_100;
Case.BaselineTension = T_100;

end