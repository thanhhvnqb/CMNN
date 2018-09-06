clear; close all; clc;
load('skel.mat');

load('results/result_basketball_k8_0.1_g0.1.mat');
e_shapes = reshape(e_shapes',15,[])';
%% Visualize shapes for each subject
% for k = 1:length(e_shapes)/3
% clf(fig)
k=60;
fprintf('Shape: %d\n',k);
S = e_shapes(3*(k-1)+1:3*(k-1)+3, :);
W = [S(1,:);S(2,:)];
fig = figure;
vis2Dskel(W,skel);
grid on;
axis on;
% set(gca,'FontSize',30);
% set(gca,'xticklabel',{[]});
% set(gca,'yticklabel',{[]});

% set(fig,'Units','Inches');
% pos = get(fig,'Position');
% set(fig,'Position',[pos(1)-2, pos(2)-6, 4, 4]);
% pos = get(fig,'Position');
% set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(fig,'2d.pdf','-dpdf','-r0')

fig = figure;
vis3Dskel_n(S,skel,[-45 30],false,'stick');
rotate3d on;
grid on;
axis on;
% set(gca,'FontSize',30);
% set(gca,'xticklabel',{[]});
% set(gca,'yticklabel',{[]});
% set(gca,'zticklabel',{[]});
% set(fig,'Units','Inches');
% pos = get(fig,'Position');
% set(fig,'Position',[pos(1)-2, pos(2)-6, 4, 4]);
% pos = get(fig,'Position');
% set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(fig,'3d_v1.pdf','-dpdf','-r0')

fig = figure;
vis3Dskel_n(S,skel,[50 30],false,'stick');
rotate3d on;
grid on;
axis on;
% set(gca,'FontSize',30);
% set(gca,'xticklabel',{[]});
% set(gca,'yticklabel',{[]});
% set(gca,'zticklabel',{[]});
% set(fig,'Units','Inches');
% pos = get(fig,'Position');
% set(fig,'Position',[pos(1)-2, pos(2)-6, 4, 4]);
% pos = get(fig,'Position');
% set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(fig,'3d_v2.pdf','-dpdf','-r0')

fig = figure;
vis3Dskel_n(S,skel,[145 30],false,'stick');
rotate3d on;
grid on;
axis on;
% set(gca,'FontSize',30);
% set(gca,'xticklabel',{[]});
% set(gca,'yticklabel',{[]});
% set(gca,'zticklabel',{[]});
% set(fig,'Units','Inches');
% pos = get(fig,'Position');
% set(fig,'Position',[pos(1)-2, pos(2)-6, 4, 4]);
% pos = get(fig,'Position');
% set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(fig,'3d_v3.pdf','-dpdf','-r0')
%     drawnow();
% end
