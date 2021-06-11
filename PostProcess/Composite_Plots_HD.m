clear; clc; close all;
%% Load the Pzf simulation results

number_of_HDs = 4;

addpath('../SRC/');

load('HDResults.mat');

CPP = [40 ,60, 80, 100, 120, 140];
E_mid_control = 583.5996;
R_mid_control = 198.9735;

for i = 1:number_of_HD
    
    Tension(i,:) = HD{i}.Tension;
      
    E_mid_baseline(i) = 1./(HD{i}.BaselineParams.cf2*HD{i}.BaselineParams.C12);

    ENDOEPI(i,:) = HD{i}.ENDOEPI;
    
    Pzf_exp(i,:) = HD{i}.Pzf_exp;
    Pzf_mod(i,:) = HD{i}.Pzf_mod;
    
    Q_exp_normalized(i,:) = HD{i}.Q_exp/HD{i}.Q_exp(4);
    Q_sim_normalized(i,:) = HD{i}.Q_sim/HD{i}.Q_exp(4);
    
    Q_exp(i,:) = HD{i}.Q_exp;
    Q_sim(i,:) = HD{i}.Q_sim;
    
    plot_resistances(HD{i});
    
end

for i = 1:number_of_HD
    
    Elastance_epi(i,:) = HD{i}.Elastance_epi*E_mid_baseline(i)/E_mid_control;
    Elastance_mid(i,:) = HD{i}.Elastance_mid*E_mid_baseline(i)/E_mid_control;
    Elastance_endo(i,:) = HD{i}.Elastance_endo*E_mid_baseline(i)/E_mid_control;
    
    R_endo(i,:) = HD{i}.RAendo/R_mid_control;
    R_mid(i,:) = HD{i}.RAmid/R_mid_control;
    R_epi(i,:) = HD{i}.RAepi/R_mid_control;
    
end

% boxplot(E_mid_baseline);
%%
hq = figure(1); hold on;

Q_sim_mean = mean(Q_sim_normalized,1);

Q_sim_h = Q_sim_mean + 2*std(Q_sim_normalized,1);
Q_sim_d = Q_sim_mean + -2*std(Q_sim_normalized,1);

plot(CPP,Q_sim_h,'k--','linewidth',1.5);
plot(CPP,Q_sim_d,'k--','linewidth',1.5);
patch([CPP fliplr(CPP)], [Q_sim_h fliplr(Q_sim_d)], [7.5 7.5 7.5]/8, 'EdgeColor' , 'none');
plot(CPP, Q_sim_mean, 'k-','linewidth',1.5);


Q_exp_mean = mean(Q_exp_normalized,1);
err_p = 2*std(Q_exp_normalized,1);
err_m = -2*std(Q_exp_normalized,1);
errorbar(CPP,Q_exp_mean,err_m,err_p,'ko','LineWidth',1.5);

set(gca,'Fontsize',14); box on
ylabel('Q/Q_{exp@100 mmHg}','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
set(gca, 'Layer', 'Top');
ylim([0 2]);
saveas(hq, 'Q_compare_HD.png');

%%
hq2 = figure(101); hold on;

Q_sim_mean = mean(Q_sim,1);

Q_sim_h = Q_sim_mean + 2*std(Q_sim,1);
Q_sim_d = Q_sim_mean + -2*std(Q_sim,1);

plot(CPP,Q_sim_h,'k--','linewidth',1.5);
plot(CPP,Q_sim_d,'k--','linewidth',1.5);
patch([CPP fliplr(CPP)], [Q_sim_h fliplr(Q_sim_d)], [7.5 7.5 7.5]/8, 'EdgeColor' , 'none');
plot(CPP, Q_sim_mean, 'k-','linewidth',1.5);


Q_exp_mean = mean(Q_exp,1);
err_p = 2*std(Q_exp,1);
err_m = -2*std(Q_exp,1);
errorbar(CPP,Q_exp_mean,err_m,err_p,'ko','LineWidth',1.5);

set(gca,'Fontsize',14); box on
ylabel('Q (mL/min)','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
set(gca, 'Layer', 'Top');
ylim([0 350]);
saveas(hq2, 'Q_HD.png');

hpzf = figure(2); hold on;

Pzf_mod_mean = mean(Pzf_mod,1);

Pzf_sim_h = Pzf_mod_mean + 2*std(Pzf_mod,1);
Pzf_sim_d = Pzf_mod_mean + -2*std(Pzf_mod,1);

plot(CPP,Pzf_sim_h,'k--','linewidth',1.5);
plot(CPP,Pzf_sim_d,'k--','linewidth',1.5);
patch([CPP fliplr(CPP)], [Pzf_sim_h fliplr(Pzf_sim_d)], [7.5 7.5 7.5]/8, 'EdgeColor' , 'none');
plot(CPP, Pzf_mod_mean, 'k-','linewidth',1.5);

Pzf_exp_mean = mean(Pzf_exp,1);
err_p = 2*std(Pzf_exp,1);
err_m = -2*std(Pzf_exp,1);
errorbar(CPP,Pzf_exp_mean,err_m,err_p,'ko','LineWidth',1.5);

set(gca,'Fontsize',14); box on
ylabel('Pzf (mmHg)','interpreter','latex','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
set(gca, 'Layer', 'Top');
ylim([-10 70.0]);
saveas(hpzf, 'Pzf_HD.png');

%%
hT = figure(3); hold on;

Tension_mean = mean(Tension,1);
Tension_sim_h = Tension_mean + 2*std(Tension,1);
Tension_sim_d = Tension_mean + -2*std(Tension,1);

plot(CPP,Tension_sim_h,'k--','linewidth',1.5);
plot(CPP,Tension_sim_d,'k--','linewidth',1.5);
patch([CPP fliplr(CPP)], [Tension_sim_h fliplr(Tension_sim_d)], [7.5 7.5 7.5]/8, 'EdgeColor' , 'none');
plot(CPP, Tension_mean, 'k-','linewidth',1.5);
set(gca,'Fontsize',14); box on
ylabel('T/T0','interpreter','latex','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
set(gca, 'Layer', 'Top');
ylim([0 1.5]);
saveas(hT, 'Tension_HD.png');

hEndoEpi = figure(4); hold on;

ENDOEPI_mean = mean(ENDOEPI,1);
ENDOEPI_sim_h = ENDOEPI_mean + 2*std(ENDOEPI,1);
ENDOEPI_sim_d = ENDOEPI_mean + -2*std(ENDOEPI,1);

plot(CPP,ENDOEPI_sim_h,'k--','linewidth',1.5);
plot(CPP,ENDOEPI_sim_d,'k--','linewidth',1.5);
patch([CPP fliplr(CPP)], [ENDOEPI_sim_h fliplr(ENDOEPI_sim_d)], [7.5 7.5 7.5]/8, 'EdgeColor' , 'none');
plot(CPP, ENDOEPI_mean, 'k-','linewidth',1.5);
set(gca,'Fontsize',14); box on
ylabel('ENDOEPI','interpreter','latex','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
set(gca, 'Layer', 'Top');
ylim([0 2.5]);
saveas(hEndoEpi, 'hEndoEpi.png');

%%
hE = figure(5);
axes('position',[0.15 0.15 0.75 0.75]); hold on;

Elastance_epi_log = log10(Elastance_epi);
Elastance_epi_mean = mean(Elastance_epi_log,1);
Elastance_epi_h = Elastance_epi_mean + 2*std(Elastance_epi_log,1);
Elastance_epi_d = Elastance_epi_mean + -2*std(Elastance_epi_log,1);

plot(CPP,Elastance_epi_h,'b--','linewidth',1.5);
plot(CPP,Elastance_epi_d,'b--','linewidth',1.5);
patch([CPP fliplr(CPP)], [Elastance_epi_h fliplr(Elastance_epi_d)], [1.5 1.5 7.5]/8, 'EdgeColor' , 'none');
alpha(0.2)
p1 = plot(CPP,Elastance_epi_mean,'b-','linewidth',1.5);

Elastance_mid_log = log10(Elastance_mid);
Elastance_mid_mean = mean(Elastance_mid_log,1);
Elastance_mid_h = Elastance_mid_mean + 2*std(Elastance_mid_log,1);
Elastance_mid_d = Elastance_mid_mean + -2*std(Elastance_mid_log,1);

plot(CPP,Elastance_mid_h,'--','linewidth',1.5,'Color',[0.0 4 0.0]/8);
plot(CPP,Elastance_mid_d,'--','linewidth',1.5,'Color',[0.0 4 0.0]/8);
patch([CPP fliplr(CPP)], [Elastance_mid_h fliplr(Elastance_mid_d)], [1.5 7.5 1.5]/8, 'EdgeColor' , 'none');
alpha(0.2)
Elastance_mid_m = mean(Elastance_mid);
p2 = plot(CPP,Elastance_mid_mean,'-','linewidth',1.5,'Color',[0.0 4 0.0]/8);

Elastance_endo_log = log10(Elastance_endo);
Elastance_endo_mean = mean(Elastance_endo_log,1);
Elastance_endo_h = Elastance_endo_mean + 2*std(Elastance_endo_log,1);
Elastance_endo_d = Elastance_endo_mean + -2*std(Elastance_endo_log,1);

plot(CPP,Elastance_endo_h,'r--','linewidth',1.5);
plot(CPP,Elastance_endo_d,'r--','linewidth',1.5);
patch([CPP fliplr(CPP)], [Elastance_endo_h fliplr(Elastance_endo_d)], [7.5 1.5 1.5]/8, 'EdgeColor' , 'none');
alpha(0.32)
Elastance_endo_m = mean(Elastance_endo);
p3 = plot(CPP,Elastance_endo_mean,'r-','linewidth',1.5);

set(gca,'Fontsize',14); box on
ylabel('log_{10}(E/E0)','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
legend([p1, p2, p3], 'Epi.','Mid.','Endo.','Location','best');
set(gca, 'Layer', 'Top');
ylim([-2 4.0]);
saveas(hE, 'Elastance_HD.png');

%%
hR = figure(51);
axes('position',[0.15 0.15 0.75 0.75]); hold on;

R_epi_mean = mean(R_epi,1);
R_epi_h = R_epi_mean + 2*std(R_epi,1);
R_epi_d = R_epi_mean + -2*std(R_epi,1);

plot(CPP,R_epi_h,'b--','linewidth',1.5);
plot(CPP,R_epi_d,'b--','linewidth',1.5);
patch([CPP fliplr(CPP)], [R_epi_h fliplr(R_epi_d)], [1.5 1.5 7.5]/8, 'EdgeColor' , 'none');
alpha(0.2)
p1 = plot(CPP,R_epi_mean,'b-','linewidth',1.5);

R_mid_mean = mean(R_mid,1);
R_mid_h = R_mid_mean + 2*std(R_mid,1);
R_mid_d = R_mid_mean + -2*std(R_mid,1);

plot(CPP,R_mid_h,'--','linewidth',1.5,'Color',[0.0 4 0.0]/8);
plot(CPP,R_mid_d,'--','linewidth',1.5,'Color',[0.0 4 0.0]/8);
patch([CPP fliplr(CPP)], [R_mid_h fliplr(R_mid_d)], [1.5 7.5 1.5]/8, 'EdgeColor' , 'none');
alpha(0.2)
% R_mid_m = mean(R_mid);
p2 = plot(CPP,R_mid_mean,'-','linewidth',1.5,'Color',[0.0 4 0.0]/8);

R_endo_mean = mean(R_endo,1);
R_endo_h = R_endo_mean + 2*std(R_endo,1);
R_endo_d = R_endo_mean + -2*std(R_endo,1);

plot(CPP,R_endo_h,'r--','linewidth',1.5);
plot(CPP,R_endo_d,'r--','linewidth',1.5);
patch([CPP fliplr(CPP)], [R_endo_h fliplr(R_endo_d)], [7.5 1.5 1.5]/8, 'EdgeColor' , 'none');
alpha(0.32)
R_endo_m = mean(R_endo);
p3 = plot(CPP,R_endo_mean,'r-','linewidth',1.5);

set(gca,'Fontsize',14); box on
ylabel('R/R0 (-)','fontsize',16);
xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
legend([p1, p2, p3], 'Epi.','Mid.','Endo.','Location','best');
set(gca, 'Layer', 'Top');
ylim([0 4.0]);
saveas(hR, 'R_HD.png');

%%
hTPzf = figure(6);
axes('position',[0.15 0.15 0.75 0.75]); hold on;
T = Tension(:);
PZF = Pzf_mod(:);
PZF_E = Pzf_exp(:);
p(1) = plot(T,PZF,'+','linewidth',1.5);
p(2) = plot(T,PZF_E,'o','linewidth',1.5);
set(gca,'Fontsize',14); box on
hold on

f=polyfit(T,PZF,1);
b = polyval(f, T);
[r1, p1] = corrcoef(T,PZF);
p(3) = plot(T,b,'b');

f2=polyfit(T,PZF_E,1);
b = polyval(f2, T);
% Bbar = mean(PZF_E);
% SStot = sum((PZF_E - Bbar).^2);
% SSreg = sum((b - Bbar).^2);
% SSres = sum((PZF_E - b).^2);
% R2E = 1 - SSres/SStot;
[r2, p2] = corrcoef(T,PZF_E);
p(4) = plot(T,b,'r');

xlabel('T/T0','interpreter','latex','fontsize',16);
ylabel('Pzf (mmHg)','interpreter','latex','fontsize',16);
legend(p,{'Model','Experiment',['Fitted Curve (Model)',' r^2=',num2str(r1(1,2)^2,'%0.2f'),' p=',num2str(p1(1,2),'%0.2f')],['Fitted Curve (Experiment)',' r^2=',...
                                                                num2str(r2(1,2)^2,'%0.2f'),' p=',num2str(p2(1,2),'%0.2f')]},'Location','NorthWest','FontSize',8);
ylim([0 60.0]);
saveas(hTPzf, 'T_Pzf.png');

%%
E_PZF = figure(7); hold on;
E = Elastance_mid_log(:);
e(1) = plot(E ,PZF,'+','linewidth',1.5);
e(2) = plot(E ,PZF_E,'o','linewidth',1.5);
set(gca,'Fontsize',14); box on
hold on


f=polyfit(E,PZF,1);
b = polyval(f, E);
[r1, p1] = corrcoef(E,PZF);
e(3) = plot(E,b,'b');

f2=polyfit(E,PZF_E,1);
b = polyval(f2, E);
[r2, p2] = corrcoef(E,PZF_E);
e(4) = plot(E,b,'r');

legend(e,{'Model','Experiment',['Fitted Curve (Model)',' r^2=',num2str(r1(1,2)^2,'%0.2f'),' p=',num2str(p1(1,2),'%0.2f')],['Fitted Curve (Experiment)',' r^2=',...
                                                                num2str(r2(1,2)^2,'%0.2f'),' p=',num2str(p2(1,2),'%0.2f')]},'Location','NorthWest','FontSize',8);


xlabel('log_{10}(E/E0)','fontsize',16);
ylabel('Pzf (mmHg)','interpreter','latex','fontsize',16);
ylim([0 60.0]);
saveas(E_PZF, 'E_Pzf.png');

movefile('*.png',['./Figs/HD']);

