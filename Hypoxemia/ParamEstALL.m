clear;clc;close all;

% Created Sep 16 by HG

addpath('../SRC');
%% Reading data / modeling / analysis based on Pzf data from John Tune:

i = 1;
Testset = Extract_Data( i , 490, 10, 0.15);
Pressures_AoPPLV;
close all;



t_off = [Testset(1).t_off, Testset(2).t_off,...
    Testset(3).t_off, Testset(4).t_off, ...
    Testset(5).t_off, Testset(6).t_off]; 

t_final = [Testset(1).t(end), Testset(2).t(end),...
    Testset(3).t(end), Testset(4).t(end), ...
    Testset(5).t(end), Testset(6).t(end)]; 

t_off = flip(t_off);
t_final = flip(t_final);
Testset = flip(Testset);

%% Parameter initialization and estimation
[bmin, bmax] = ParamBounds();

p = gcp('nocreate'); % If no pool, do not create new one.
if isempty( p )==1
    parpool(4);
end

rng('shuffle');

fun = @(x)obj_fun(x, Testset, t_final, t_off);


%% GA
[gaoptions, nvar] = GA_setup();

startTime = tic;

gasol = ga(fun, nvar, [], [], [], [], bmin, bmax, [], gaoptions);

optTime = toc(startTime);

save GA_RES

%% Final Evaulation
Final_Eval;
