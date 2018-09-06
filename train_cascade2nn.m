clc; close all; clear;
load('skel.mat');
addpath(genpath('../ZhouCode'));
elem = 'traindt';
K = 8;
lam = 0.1;
nT = 10;

gam = 0.1;
load(['models/shapeDict_train_data_k', num2str(K),'_',num2str(lam),'.mat']);
neuralnet_up = cell(nT,1);
neuralnet_down = cell(nT,1);
load('Data/train_data.mat');
n3dshape = length(allshapes)/3;
r3dshapes = reshape(allshapes',[],n3dshape)';
e_shapes = zeros(size(r3dshapes));
Sorigs = zeros(size(r3dshapes));
maxshape = n3dshape;
% parfor_progress(maxshape);
% parfor i=1:maxshape
%     % align
%     XYZ = r3dshapes(i,:);
%     XYZ = reshape(XYZ',[],3)';
% 
%     Torig = mean(XYZ,2)*ones(1,size(XYZ,2));
%     Sorigin = XYZ - Torig;
%     W = [Sorigin(1,:);Sorigin(2,:)];
%     Sorigs(i,:) = reshape(Sorigin',[],1)';
%     % run algorithm
%     [S,info] = ssr2D3D_alm(W,B,lam,inf,'verb',false);
%     e_shapes(i,:) = reshape(S',[],1)';
%     parfor_progress;
% end
% parfor_progress(0);
% save(['Data/reconstructShapes_k', num2str(K),'_',num2str(lam),'.mat'],'e_shapes','Sorigs');

load(['Data/reconstructShapes_k', num2str(K),'_',num2str(lam),'.mat']);
neuralnet_up{1} = feedforwardnet([20 20],'trainscg');
neuralnet_up{1}.divideParam.trainRatio = 80;
neuralnet_up{1}.divideParam.valRatio = 20;
neuralnet_up{1}.divideParam.testRatio = 0;
neuralnet_down{1} = feedforwardnet([20 20],'trainscg');
neuralnet_down{1}.divideParam.trainRatio = 80;
neuralnet_down{1}.divideParam.valRatio = 20;
neuralnet_down{1}.divideParam.testRatio = 0;
new_shapes = e_shapes;
new_shapes(1:30,:) = Sorigs(1:30,:);
X = cell(nT,1);
Y_up = cell(nT,1);
Y_down = cell(nT,1);
X{1} = [Sorigs(:,1:30) new_shapes(:,31:45)];
Y_up{1} = (Sorigs(:,38:45) - new_shapes(:,38:45)) * 100;
Y_down{1} = (Sorigs(:,31:37) - new_shapes(:,31:37)) * 100;
fprintf(['Train neuralnet K: ',num2str(K),', lam: ',num2str(lam),'\n']);
fprintf(['Train loop: 1\n']);
[neuralnet_up{1}, ~] = train(neuralnet_up{1},X{1}',Y_up{1}','useGPU','yes');
[neuralnet_down{1}, ~] = train(neuralnet_down{1},X{1}',Y_down{1}','useGPU','yes');
gam = gam / 100;
for j = 2:nT
    fprintf(['Train loop: ',num2str(j),'\n']);
    neuralnet_up{j} = feedforwardnet([20 20],'trainscg');
    neuralnet_up{j}.divideParam.trainRatio = 80;
    neuralnet_up{j}.divideParam.valRatio = 20;
    neuralnet_up{j}.divideParam.testRatio = 0;
    neuralnet_down{j} = feedforwardnet([20 20],'trainscg');
    neuralnet_down{j}.divideParam.trainRatio = 80;
    neuralnet_down{j}.divideParam.valRatio = 20;
    neuralnet_down{j}.divideParam.testRatio = 0;
    new_shapes(:,38:45) = new_shapes(:,38:45) + gam*neuralnet_up{j-1}(X{j-1}')';
    new_shapes(:,31:37) = new_shapes(:,31:37) + gam*neuralnet_down{j-1}(X{j-1}')';
    X{j} = [Sorigs(:,1:30) new_shapes(:,31:45)];
    Y_up{j} = (Sorigs(:,38:45) - new_shapes(:,38:45)) * 100;
    Y_down{j} = (Sorigs(:,31:37) - new_shapes(:,31:37)) * 100;
    [neuralnet_up{j}, ~] = train(neuralnet_up{j},X{j}',Y_up{j}','useGPU','yes');
    [neuralnet_down{j}, ~] = train(neuralnet_down{j},X{j}',Y_down{j}','useGPU','yes');
end
filename = ['models/neuralnet2nn_k',...
    num2str(K),'_',num2str(lam),'_g',num2str(gam * 100),'.mat'];
save(filename, 'neuralnet_up','neuralnet_down','nT');
