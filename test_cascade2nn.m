clc; close all; clear;
addpath(genpath('../ZhouCode'));
load('skel.mat');
dataset = {'acrobatics','basketball','boxing', 'dance','gymnastics',...
    'jump','run','soccer','walk'};
mkdir 'results';
K = 8;
lam = 0.1;
gam = 0.1;
gam = gam / 100;
for idx_data = 1:length(dataset)
    shape_p_loop = 500;
    data = dataset(idx_data);
    load(['Data/test_',char(data),'.mat']);
    n3dshape = length(allshapes)/3;
    r3dshapes = reshape(allshapes',[],n3dshape)';
    fprintf(['data: ',char(data),', K: ',num2str(K),', lam: ',num2str(lam),', gam: ',num2str(gam * 100),...
        ', num_shape: ',num2str(n3dshape),'\n']);
    load(['models/shapeDict_train_data_k', num2str(K),'_',num2str(lam),'.mat']);
    load(['models/neuralnet2nn_k', num2str(K),'_',num2str(lam),'_g',num2str(gam * 100),'.mat']);
    filename = ['results/result_', char(data),'_k',...
        num2str(K),'_',num2str(lam),'_g',num2str(gam * 100),'.mat'];
    meanErr = zeros(1, n3dshape);
    time = zeros(1, n3dshape);
    e_shapes = zeros(size(r3dshapes));
    maxshape = n3dshape;
    parfor_progress(maxshape);
    parfor i = 1:maxshape
        % align
        XYZ = r3dshapes(i,:);
        XYZ = reshape(XYZ',[],3)';

        Torig = mean(XYZ,2)*ones(1,size(XYZ,2));
        Sorigin = XYZ - Torig;
        W = Sorigin(1:2,:);
        tic
        % run algorithm
        [S,info] = ssr2D3D_alm(W,B,lam,inf,'verb',false);
        S(1:2,:) = W;

        W = reshape(W',[],1)';
        for j = 1:nT
            X = [W S(3,:)];
            S(3,8:15) = S(3,8:15) + gam*neuralnet_up{j}(X')';
            S(3,1:7) = S(3,1:7) + gam*neuralnet_down{j}(X')';
        end
        time(i) = toc;
        meanErr(i) = mean(sqrt(sum((Sorigin-S).^2)));
        S = S + Torig;
        e_shapes(i,:) = reshape(S',[],1)';
        parfor_progress;
    end
    parfor_progress(0);
    save(filename, 'meanErr', 'time', 'e_shapes');
    [~,~,v] = find(meanErr); mean(v)
end
