clear; clc; close all;
%% Load the Pzf simulation results

number_of_controls = 6;

addpath('../SRC/');

load('AllResults.mat');

for i = 2:5
    
    mat_files = dir(['../Control',num2str(i),'/*.mat']);
    
    Control{i} = load(['../Control',num2str(i),'/',mat_files(end).name]);
    
    Control{i}.name = ['Control',num2str(i)];
    
    Control{i} = Evaluation(Control{i});
    
    Control{i} = Calculations(Control{i});
    
    close all

end

save('AllResults.mat');
