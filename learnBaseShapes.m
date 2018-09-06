close all; clear; clc;
addpath(genpath('../ZhouCode'));
load('skel.mat');
filetrain = 'train_data';
load(['Data/',filetrain,'.mat']);
mkdir 'models';
% K = 32; % size of dictionary 
% lam = 0.1; % regularization weight 

% Ks = [4 4 8 8 64 64 128];
% lams = [0.1 1 0.1 1 0.1 1 1];
K = 8; % size of dictionary 
lam = 0.1; % regularization weight 

[B, mu,ERR,SP] = learnPoseDict(allshapes, skel, K, lam);
filename = ['models/shapeDict_',filetrain,'_k', num2str(K),'_',num2str(lam),'.mat'];
save(filename, 'B', 'mu', 'skel', 'ERR', 'SP','lam');