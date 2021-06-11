clear; clc; close all;
%% Load the Pzf simulation results

number_of_dobs = 5;

addpath('../SRC/');

for i = 1:number_of_dobs
    
    mat_files = dir(['../Dob',num2str(i),'/*.mat']);
    
    Dob{i} = load(['../Dob',num2str(i),'/',mat_files(end).name]);
    
    Dob{i}.name = ['Dob',num2str(i)];
    
    Dob{i} = Evaluation_PZF_inf(Dob{i});
    
%     Control{i} = Calculations(Control{i});
    
    close all
end

save('AllResultsDob_inf.mat');
