function vis2Dskel(W,skel)
W = normalizeS(W);
connect = skelConnectionMatrix(skel);
indices = find(connect);
[I, J] = ind2sub(size(connect), indices);

linewidth = 1.5;
% markersize = 5;
% plot(W(1,:),W(2,:),'o','MarkerSize',markersize,...
%     'MarkerEdgeColor',color,'MarkerFaceColor',color);
% hold on
% for i =1:size(W,2)
%     text(W(1,i),W(2,i),int2str(i));
% end
for i = 1:length(indices)
    line([W(1,I(i)) W(1,J(i))], ...
         [W(2,I(i)) W(2,J(i))],'color',skel.tree(I(i)).color,'LineWidth',linewidth);
end

axis equal
% ylim([1.2*min(W(2,:)) 1.2*max(W(2,:))]);

end


function connection = skelConnectionMatrix(skel)

connection = zeros(length(skel.tree));
for i = 1:length(skel.tree);
    for j = 1:length(skel.tree(i).children)
        connection(i, skel.tree(i).children(j)) = 1;
    end
end

end
function S = normalizeS(S)
S = S / mean(std(S, 1, 2));
S = S - mean(S,2)*ones(1,size(S,2));
end