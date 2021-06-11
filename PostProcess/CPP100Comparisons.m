clear; clc; close all;
%% Load the Pzf simulation results

number_of_controls = 6;
number_of_dobs = 5;

addpath('../SRC/');

load('AllResults.mat');
load('DoBResults.mat');
load('HDResults.mat');

CPP = [40 ,60, 80, 100, 120, 140];

for i = 1:number_of_controls
    
    Tension(i,:) = Control{i}.Tension;
    
    Elastance_epi(i,:) = Control{i}.Elastance_epi;
    Elastance_mid(i,:) = Control{i}.Elastance_mid;
    Elastance_endo(i,:) = Control{i}.Elastance_endo;
    
    E_mid_baseline_Control(i) = 1./(Control{i}.BaselineParams.cf2*Control{i}.BaselineParams.C12);
    R_mid_baseline_Control(i) = Control{i}.RAmid(4);

    ENDOEPI(i,:) = Control{i}.ENDOEPI;
    
    Pzf_exp(i,:) = Control{i}.Pzf_exp;
    Pzf_mod(i,:) = Control{i}.Pzf_mod;
    
    Q_exp(i,:) = Control{i}.Q_exp/Control{i}.Q_exp(4);
    Q_sim(i,:) = Control{i}.Q_sim/Control{i}.Q_exp(4);
    
end


for i = 1:number_of_dobs
    
    Tension(i,:) = Dob{i}.Tension;
    
    Elastance_epi(i,:) = Dob{i}.Elastance_epi;
    Elastance_mid(i,:) = Dob{i}.Elastance_mid;
    Elastance_endo(i,:) = Dob{i}.Elastance_endo;
    
    E_mid_baseline_Dob(i) = 1./(Dob{i}.BaselineParams.cf2*Dob{i}.BaselineParams.C12);
    R_mid_baseline_Dob(i) = Dob{i}.RAmid(4);
    
    ENDOEPI(i,:) = Dob{i}.ENDOEPI;
    
    Pzf_exp(i,:) = Dob{i}.Pzf_exp;
    Pzf_mod(i,:) = Dob{i}.Pzf_mod;
    
    Q_exp(i,:) = Dob{i}.Q_exp/Dob{i}.Q_exp(4);
    Q_sim(i,:) = Dob{i}.Q_sim/Dob{i}.Q_exp(4);
    
end

for i = 1:number_of_HD
    
    Tension(i,:) = HD{i}.Tension;
    
    Elastance_epi(i,:) = HD{i}.Elastance_epi;
    Elastance_mid(i,:) = HD{i}.Elastance_mid;
    Elastance_endo(i,:) = HD{i}.Elastance_endo;
    
    E_mid_baseline_HD(i) = 1./(HD{i}.BaselineParams.cf2*HD{i}.BaselineParams.C12);
    R_mid_baseline_HD(i) = HD{i}.RAmid(4);    
    
    ENDOEPI(i,:) = HD{i}.ENDOEPI;
    
    Pzf_exp(i,:) = HD{i}.Pzf_exp;
    Pzf_mod(i,:) = HD{i}.Pzf_mod;
    
    Q_exp(i,:) = HD{i}.Q_exp/HD{i}.Q_exp(4);
    Q_sim(i,:) = HD{i}.Q_sim/HD{i}.Q_exp(4);
    
end

g1 = repmat({'Control'},number_of_controls,1);
g2 = repmat({'Anemia'},number_of_HD,1);
g3 = repmat({'Dobutamine+Anemia'},number_of_dobs,1);
g = [g1;g2;g3];
E_mid_baseline = [E_mid_baseline_Control, E_mid_baseline_HD, E_mid_baseline_Dob];
boxplot(E_mid_baseline,g,'PlotStyle','compact','LabelOrientation','horizontal')
ylabel('Midwall Elastance (mmHg/mL)');

SpecimenPairs = [2,2;
    3,1;
    4,3;
    5,4];

SpecimenIDs = {'#10013','#10011','#10015','#10276'};

figure(2); hold on
figure(3); hold on
figure(4); hold on
figure(5); hold on
figure(6); hold on
figure(7); hold on
% figure(8); hold on
figure(100); hold on
figure(101);hold on

for i = 1:length(SpecimenPairs)
    
    figure(2);
    p(i) = plot([1 2 3],[E_mid_baseline_Control(SpecimenPairs(i,1)) E_mid_baseline_HD(SpecimenPairs(i,2)) E_mid_baseline_Dob(SpecimenPairs(i,2))],'o-','linewidth',1.5);
    
    figure(3);
    q(i) = plot([1 2 3],[Control{SpecimenPairs(i,1)}.Q_exp(4) HD{SpecimenPairs(i,2)}.Q_exp(4) Dob{SpecimenPairs(i,2)}.Q_exp(4)],'o-','linewidth',1.5);
    
    figure(4);
    e(i) = plot([1 2 3],[Control{SpecimenPairs(i,1)}.ENDOEPI(4) HD{SpecimenPairs(i,2)}.ENDOEPI(4) Dob{SpecimenPairs(i,2)}.ENDOEPI(4)],'o-','linewidth',1.5);
    
    figure(5);
    r0(i) = plot([1 2 3],[Control{SpecimenPairs(i,1)}.gasol(2)*Control{SpecimenPairs(i,1)}.BaselineParams.R0m HD{SpecimenPairs(i,2)}.gasol(2)*HD{SpecimenPairs(i,2)}.BaselineParams.R0m...
                                                    Dob{SpecimenPairs(i,2)}.gasol(2)*Dob{SpecimenPairs(i,2)}.BaselineParams.R0m],'o-','linewidth',1.5);
    
    figure(6);
    v0(i) = plot([1 2 3],[Control{SpecimenPairs(i,1)}.gasol(3) HD{SpecimenPairs(i,2)}.gasol(3) Dob{SpecimenPairs(i,2)}.gasol(3)],'o-','linewidth',1.5);
    
    figure(7);
    v0(i) = plot([1 2 3],[Control{SpecimenPairs(i,1)}.BaselineParams.Vc HD{SpecimenPairs(i,2)}.BaselineParams.Vc Dob{SpecimenPairs(i,2)}.BaselineParams.Vc],'o-','linewidth',1.5);
    
%     
%     figure(8);
%     subplot(1,3,1); hold on
%     Cpa(i) = plot([1 2],[Control{SpecimenPairs(i,1)}.BaselineParams.C_PA Dob{SpecimenPairs(i,2)}.BaselineParams.C_PA],'o-','linewidth',1.5);
%     subplot(1,3,2); hold on
%     Lpa(i) = plot([1 2],[Control{SpecimenPairs(i,1)}.BaselineParams.L_PA Dob{SpecimenPairs(i,2)}.BaselineParams.L_PA],'o-','linewidth',1.5);
%     subplot(1,3,3); hold on
%     Rpa(i) = plot([1 2],[Control{SpecimenPairs(i,1)}.BaselineParams.R_PA Dob{SpecimenPairs(i,2)}.BaselineParams.R_PA],'o-','linewidth',1.5);
%     
%     figure(8+i);
%     
%     Elastance_epi_con(i,:) = Control{SpecimenPairs(i,1)}.Elastance_epi*E_mid_baseline_Control(SpecimenPairs(i,1))/E_mid_baseline_Control(SpecimenPairs(i,1));
%     Elastance_mid_con(i,:) = Control{SpecimenPairs(i,1)}.Elastance_mid*E_mid_baseline_Control(SpecimenPairs(i,1))/E_mid_baseline_Control(SpecimenPairs(i,1));
%     Elastance_endo_con(i,:) = Control{SpecimenPairs(i,1)}.Elastance_endo*E_mid_baseline_Control(SpecimenPairs(i,1))/E_mid_baseline_Control(SpecimenPairs(i,1));
%     
%     Elastance_epi_dob(i,:) = Dob{SpecimenPairs(i,2)}.Elastance_epi*E_mid_baseline_Dob(SpecimenPairs(i,2))/E_mid_baseline_Control(SpecimenPairs(i,1));
%     Elastance_mid_dob(i,:) = Dob{SpecimenPairs(i,2)}.Elastance_mid*E_mid_baseline_Dob(SpecimenPairs(i,2))/E_mid_baseline_Control(SpecimenPairs(i,1));
%     Elastance_endo_dob(i,:) = Dob{SpecimenPairs(i,2)}.Elastance_endo*E_mid_baseline_Dob(SpecimenPairs(i,2))/E_mid_baseline_Control(SpecimenPairs(i,1));
%     
%     subplot(3,1,1); hold on
%     plot(CPP,log10(Elastance_epi_con(i,:)),'linewidth',1.5);
%     plot(CPP,log10(Elastance_epi_dob(i,:)),'linewidth',1.5);
%     box on;
%     title(SpecimenIDs{i});
%     legend('Control','D+H','Location','NorthWest');
%     ylabel('log(E/E0)','interpreter','latex','fontsize',16);
% %     xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
%     
%     subplot(3,1,2); hold on
%     plot(CPP,log10(Elastance_mid_con(i,:)),'linewidth',1.5);
%     plot(CPP,log10(Elastance_mid_dob(i,:)),'linewidth',1.5);
%     box on;
%     legend('Control','D+H','Location','NorthWest');
%     ylabel('log(E/E0)','interpreter','latex','fontsize',16);
% %     xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
%     
%     subplot(3,1,3); hold on
%     plot(CPP,log10(Elastance_endo_con(i,:)),'linewidth',1.5);
%     plot(CPP,log10(Elastance_endo_dob(i,:)),'linewidth',1.5);
%     box on;
%     legend('Control','D+H','Location','NorthWest');
%     ylabel('log(E/E0)','interpreter','latex','fontsize',16);
%     xlabel('CPP (mmHg)','interpreter','latex','fontsize',16);
%     saveas(figure(8+i), ['E_',SpecimenIDs{i},'Q.png']);
    
    
    figure(100);
    pzf0(i) = plot([1 2 3],[Control{SpecimenPairs(i,1)}.Pzf_mod(4) HD{SpecimenPairs(i,2)}.Pzf_mod(4)  Dob{SpecimenPairs(i,2)}.Pzf_mod(4)],'o-','linewidth',1.5);

    figure(101);
    Res(i) = plot([1 2 3],[Control{SpecimenPairs(i,1)}.RAmid(4) HD{SpecimenPairs(i,2)}.RAmid(4)  Dob{SpecimenPairs(i,2)}.RAmid(4)],'o-','linewidth',1.5);
    
end

h2 = figure(2);
xlim([0.5 3.5])
names = {'Control','Anemia','Anemia+Dobutamine'};
set(gca,'xtick',[1 2 3],'XTickLabel',names);
legend(p,SpecimenIDs,'Location','best');
ylabel('Midwall Elastance (mmHg/mL)');
box on;
saveas(h2, 'E.png');

h3 = figure(3);
xlim([0.5 3.5])
set(gca,'xtick',[1 2 3],'XTickLabel',names);
legend(q,SpecimenIDs,'Location','best');
ylabel('Flow (mL/min)');
box on;
saveas(h3, 'Q.png');

h4 = figure(4);
xlim([0.5 3.5])
set(gca,'xtick',[1 2 3],'XTickLabel',names);
legend(e,SpecimenIDs,'Location','best');
ylabel('ENDO/EPI (-)');
box on;
saveas(h4, 'ENDOEPI.png');

h5 = figure(5);
xlim([0.5 3.5])
set(gca,'xtick',[1 2 3],'XTickLabel',names);
legend(r0,SpecimenIDs,'Location','best');
ylabel('Reference Resistance (mmHg/(mL/sec))');
box on;
saveas(h5, 'R0.png');

h6 = figure(6);
xlim([0.5 3.5])
set(gca,'xtick',[1 2 3],'XTickLabel',names);
legend(v0,SpecimenIDs,'Location','best');
ylabel('Reference Volume (mL)');
box on;
saveas(h6, 'V0.png');

h7 = figure(7);
xlim([0.5 3.5])
set(gca,'xtick',[1 2 3],'XTickLabel',names);
legend(v0,SpecimenIDs,'Location','best');
ylabel('Collapsed Volume (mL)');
box on;
saveas(h7, 'Vc.png');
% 
% h8 = figure(8);
% subplot(1,3,1);
% xlim([0.5 2.5])
% names1 = {'Control','H+D'};
% set(gca,'xtick',[1 2],'XTickLabel',names1);
% ylabel('Penetrating Artery and Tubing Capacitance (mL/mmmHg)');
% box on;
% subplot(1,3,2);
% xlim([0.5 2.5])
% set(gca,'xtick',[1 2],'XTickLabel',names1);
% ylabel('Penetrating Artery and Tubing Inductance mmHg/(mL/sec^2)');
% box on;
% subplot(1,3,3);
% xlim([0.5 2.5])
% set(gca,'xtick',[1 2],'XTickLabel',names1);
% ylabel('Penetrating Artery and Tubing Resistance mmHg/(mL/sec)');
% box on;
% saveas(h8, 'Tubing.png');


h100 = figure(100);
xlim([0.5 3.5])
set(gca,'xtick',[1 2 3],'XTickLabel',names);
legend(pzf0,SpecimenIDs);
ylabel('Pzf (mmHg)');
box on;
saveas(h100, 'PZF.png');

h101 = figure(101);
xlim([0.5 3.5])
set(gca,'xtick',[1 2 3],'XTickLabel',names);
legend(Res,SpecimenIDs);
ylabel('Res (mmHg/(mL/s))');
box on;
saveas(h101, 'R.png');

movefile('*.png',['./Figs/Pairwise']);
