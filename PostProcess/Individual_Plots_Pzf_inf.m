clear; clc; close all;
%% Load the Pzf simulation results

number_of_controls = 6;

addpath('../SRC/');

for i = 1:number_of_controls
    
    mat_files = dir(['../Control',num2str(i),'/*.mat']);
    
    Control{i} = load(['../Control',num2str(i),'/',mat_files(end).name]);
    
    Control{i}.name = ['Control',num2str(i)];
    
    Control{i} = Evaluation_PZF_inf(Control{i});
    
%     Control{i} = Calculations(Control{i});
    
    close all
end

save('AllResultsControl_inf.mat');
