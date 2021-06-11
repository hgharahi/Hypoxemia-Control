function [gaoptions, nvar] = GA_setup()

nvar = 15;

gaoptions = optimoptions('ga','MaxGenerations',1200,'Display','iter');
    gaoptions = optimoptions(gaoptions,'UseParallel',true);
    gaoptions = optimoptions(gaoptions,'PopulationSize',2);
    gaoptions = optimoptions(gaoptions,'FunctionTolerance',1e-6);
    gaoptions = optimoptions(gaoptions,'OutputFcn',@GA_DISP);
