function Case = Evaluation(Case)

%% Final Evualtion
[Results_40, ENDOEPI_40, Qmean_40, FlowAverage_40, h1_40, h2_40, T_40, Params_40, Pzf_40]   = eval_fun( Case.gasol, Case.Testset(1), Case.t_final, Case.t_off);

disp(['Average flow: Experiment: ' num2str(FlowAverage_40)]);
disp(['Average flow: Simulation: ' num2str(Qmean_40)]);
saveas(h1_40, [Case.name,'P_40.png']);
saveas(h2_40, [Case.name,'F_40.png']);


[Results_60, ENDOEPI_60, Qmean_60, FlowAverage_60, h1_60, h2_60, T_60, Params_60, Pzf_60]   = eval_fun( Case.gasol, Case.Testset(2), Case.t_final, Case.t_off);

disp(['Average flow: Experiment: ' num2str(FlowAverage_60)]);
disp(['Average flow: Simulation: ' num2str(Qmean_60)]);
saveas(h1_60, [Case.name,'P_60.png']);
saveas(h2_60, [Case.name,'F_60.png']);

[Results_80, ENDOEPI_80, Qmean_80, FlowAverage_80, h1_80, h2_80, T_80, Params_80, Pzf_80]   = eval_fun( Case.gasol, Case.Testset(3), Case.t_final, Case.t_off);

disp(['Average flow: Experiment: ' num2str(FlowAverage_80)]);
disp(['Average flow: Simulation: ' num2str(Qmean_80)]);
saveas(h1_80, [Case.name,'P_80.png']);
saveas(h2_80, [Case.name,'F_80.png']);

[Results_100, ENDOEPI_100, Qmean_100, FlowAverage_100, h1_100, h2_100, T_100, Params_100, Pzf_100]   = eval_fun_BaseLine( Case.gasol, Case.Testset(4), Case.t_final, Case.t_off);

disp(['Average flow: Experiment: ' num2str(FlowAverage_100)]);
disp(['Average flow: Simulation: ' num2str(Qmean_100)]);
saveas(h1_100, [Case.name,'P_100.png']);
saveas(h2_100, [Case.name,'F_100.png']);


[Results_120, ENDOEPI_120, Qmean_120, FlowAverage_120, h1_120, h2_120, T_120, Params_120, Pzf_120]   = eval_fun( Case.gasol, Case.Testset(5), Case.t_final, Case.t_off);


disp(['Average flow: Experiment: ' num2str(FlowAverage_120)]);
disp(['Average flow: Simulation: ' num2str(Qmean_120)]);
saveas(h1_120, [Case.name,'P_120.png']);
saveas(h2_120, [Case.name,'F_120.png']);

[Results_140, ENDOEPI_140, Qmean_140, FlowAverage_140, h1_140, h2_140, T_140, Params_140, Pzf_140]   = eval_fun( Case.gasol, Case.Testset(6), Case.t_final, Case.t_off);

disp(['Average flow: Experiment: ' num2str(FlowAverage_140)]);
disp(['Average flow: Simulation: ' num2str(Qmean_140)]);
saveas(h1_140, [Case.name,'P_140.png']);
saveas(h2_140, [Case.name,'F_140.png']);


%% Combined plots

CPP = [40 ,60, 80, 100, 120, 140];

Case.Q_sim = [Qmean_40, Qmean_60, Qmean_80, Qmean_100, Qmean_120, Qmean_140];

Case.Q_exp = [FlowAverage_40, FlowAverage_60, FlowAverage_80, FlowAverage_100, FlowAverage_120, FlowAverage_140];

Case.ENDOEPI = [ENDOEPI_40, ENDOEPI_60, ENDOEPI_80, ENDOEPI_100, ENDOEPI_120, ENDOEPI_140];

Case.Results = [Results_40, Results_60, Results_80, Results_100, Results_120, Results_140];

%%
hQ = figure(3);
 hold on;%axes('position',[0.15 0.15 0.75 0.75]);
pExp = scatter(CPP,Case.Q_exp,'k+','LineWidth',3);
pSim = plot(CPP,Case.Q_sim,'ro','linewidth',3);
set(gca,'Fontsize',22); box on
ylabel('Flow (ml/min)','interpreter','latex','fontsize',22);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',22);
legend([pExp pSim],'Data','Model','Location','best','FontSize',22);
saveas(hQ, 'Q_comp.png');

%%
hEndo = figure(4);
hold on;% axes('position',[0.15 0.15 0.75 0.75]); 
plot(CPP,Case.ENDOEPI,'r-','linewidth',2);
ylim([0 2.0]);
set(gca,'Fontsize',22); box on
ylabel('ENDO/EPI','interpreter','latex','fontsize',22);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',22);
saveas(hEndo, [Case.name,'ENDOEPI.png']);

%%
hT = figure(5);
Case.Tension = [T_40, T_60, T_80, T_100, T_120, T_140]/T_100;
axes('position',[0.15 0.15 0.75 0.75]); hold on;
plot(CPP,Case.Tension,'k-','linewidth',1.5);
set(gca,'Fontsize',14); box on
ylabel('T/T0','interpreter','latex','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
saveas(hT, [Case.name,'Tension.png']);

%%
Elastance_epi = 1./(Params_40.cf1*[Params_40.C11, Params_60.C11, Params_80.C11, Params_100.C11, Params_120.C11, Params_140.C11]);
Elastance_mid = 1./(Params_40.cf2*[Params_40.C12, Params_60.C12, Params_80.C12, Params_100.C12, Params_120.C12, Params_140.C12]);
Elastance_endo = 1./[Params_40.C13, Params_60.C13, Params_80.C13, Params_100.C13, Params_120.C13, Params_140.C13];

Case.Elastance_epi = Elastance_epi/Elastance_mid(4);
Case.Elastance_endo = Elastance_endo/Elastance_mid(4);
Case.Elastance_mid = Elastance_mid/Elastance_mid(4);

hE = figure(6);
axes('position',[0.15 0.15 0.75 0.75]); hold on;
p1 = plot(CPP,log10(Case.Elastance_epi),'b-','linewidth',1.5);
p2 = plot(CPP,log10(Case.Elastance_mid),'-','linewidth',1.5,'Color',[0.0 4 0.0]/8);
p3 = plot(CPP,log10(Case.Elastance_endo),'r-','linewidth',1.5);

set(gca,'Fontsize',14); box on
ylabel('log(E/E0)','interpreter','latex','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
legend([p1, p2, p3], 'Epi.','Mid.','Endo.','Location','best');
saveas(hE, [Case.name,'E.png']);



%%
Case.Pzf_mod = [Pzf_40(1), Pzf_60(1), Pzf_80(1), Pzf_100(1), Pzf_120(1), Pzf_140(1)];
Case.Pzf_exp = [Pzf_40(2), Pzf_60(2), Pzf_80(2), Pzf_100(2), Pzf_120(2), Pzf_140(2)];

hPzf = figure(7);
axes('position',[0.15 0.15 0.75 0.75]); hold on;
p1 = plot(CPP,Case.Pzf_mod,'k-','linewidth',1.5);
p2 = scatter(CPP,Case.Pzf_exp,'ok','LineWidth',1.5);
ylabel('Pzf (mmHg)','interpreter','latex','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
set(gca,'Fontsize',14); box on
legend([p1, p2], 'Model','Experiment','Location','best');
saveas(hPzf, [Case.name,'Pzf.png']);

%%
hTPzf = figure(8);
axes('position',[0.15 0.15 0.75 0.75]); hold on;
plot(Case.Tension,Case.Pzf_mod,'ko','linewidth',1.5);
set(gca,'Fontsize',14); box on
legend('Model','Location','best');
hold on
f=fit(Case.Tension',Case.Pzf_mod','poly1');
plot(f)
xlabel('T/T0','interpreter','latex','fontsize',16);
ylabel('Pzf (mmHg)','interpreter','latex','fontsize',16);
saveas(hTPzf, [Case.name,'T_Pzf.png']);


fclose all;
movefile('*.png',['./Figs/',Case.name]);

Case.BaselineParams = Params_100;
Case.BaselineTension = T_100;

end