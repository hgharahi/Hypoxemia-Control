clear; clc; close all;
%% Load the Pzf simulation results

number_of_dobs = 5;

addpath('../SRC/');

load('DoBResults.mat');
% for i = 1:number_of_dobs
    i=3;
%     
    mat_files = dir(['../Dob',num2str(i),'/*.mat']);
%     
    Dob{i} = load(['../Dob',num2str(i),'/',mat_files(end).name]);
%     
    Dob{i}.name = ['Dob',num2str(i)];
%     
%     if i == 4
%         
%         Dob{i}.t_final = 10*ones(1,6);
%     
%     elseif i ==5
%         
%         Dob{i}.t_final(4) = 10.5;
%     
%     end
%     
    Dob{i} = Evaluation(Dob{i});
    
    Dob{i} = Calculations(Dob{i});
    
    close all
    
% end

save('DoBResults.mat');