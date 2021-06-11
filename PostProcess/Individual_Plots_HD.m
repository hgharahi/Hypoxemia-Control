clear; clc; close all;
%% Load the Pzf simulation results

number_of_HD = 4;

addpath('../SRC/');


load('HDResults.mat');

% for i = 1:number_of_HD
    i = 4;
    mat_files = dir(['../HD',num2str(i),'/*.mat']);
    
    HD{i} = load(['../HD',num2str(i),'/',mat_files(end).name]);
    
    HD{i}.name = ['HD',num2str(i)];
      
    HD{i} = Evaluation(HD{i});
    
    HD{i} = Calculations(HD{i});
    
%     close all
%     
% end

% save('HDResults.mat');