function Case = Calculations(Case)
%% This function evaluate the steady state hemodynamics and resistances.

for i = 1:6
    
    Ppa = Case.Results{1,2*i-1}.P_PA(Case.Results{1,2*i-1}.t>Case.t_off(i)-2*Case.Testset(i).T & Case.Results{1,2*i-1}.t<=Case.t_off(i));
%     Ppa = mean(Ppa);
    
    Qendo = Case.Results{1,2*i-1}.Q13(Case.Results{1,2*i-1}.t>Case.t_off(i)-2*Case.Testset(i).T & Case.Results{1,2*i-1}.t<=Case.t_off(i));
%     Qendo = mean(Qendo);
    
    Pendo = Case.Results{1,2*i-1}.P13(Case.Results{1,2*i-1}.t>Case.t_off(i)-2*Case.Testset(i).T & Case.Results{1,2*i-1}.t<=Case.t_off(i));
%     Pendo = mean(Pendo);
    
    Case.RAendo(i) = mean((Ppa - Pendo)./Qendo);
    
    Qmid = Case.Results{1,2*i-1}.Q12(Case.Results{1,2*i-1}.t>Case.t_off(i)-2*Case.Testset(i).T & Case.Results{1,2*i-1}.t<=Case.t_off(i));
%     Qmid = mean(Qmid);
    
    Pmid = Case.Results{1,2*i-1}.P12(Case.Results{1,2*i-1}.t>Case.t_off(i)-2*Case.Testset(i).T & Case.Results{1,2*i-1}.t<=Case.t_off(i));
%     Pmid = mean(Pmid);
    
    Case.RAmid(i) = mean((Ppa - Pmid)./Qmid);
    
    Qepi = Case.Results{1,2*i-1}.Q11(Case.Results{1,2*i-1}.t>Case.t_off(i)-2*Case.Testset(i).T & Case.Results{1,2*i-1}.t<=Case.t_off(i));
%     Qepi = mean(Qepi);
    
    Pepi = Case.Results{1,2*i-1}.P11(Case.Results{1,2*i-1}.t>Case.t_off(i)-2*Case.Testset(i).T & Case.Results{1,2*i-1}.t<=Case.t_off(i));
%     Pepi = mean(Pepi);
    
    Case.RAepi(i) = mean((Ppa - Pepi)./Qepi);
    
end