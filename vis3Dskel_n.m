function vis3Dskel_n(shape,skel,viewpoint,flagShowCam,mode)

% note that the visualization frame is left-handed
% while the world frame is ususlly right-handed
shape(3,:) = -shape(3,:);

connect = skelConnectionMatrix(skel);
indices = find(connect);
[I, J] = ind2sub(size(connect), indices);
shape = normalizeS(shape);

if nargin < 3
    viewpoint = [0 0];
end
if nargin < 4
    flagShowCam = true;
end
if nargin < 5
    mode = 'ellipse';
end

%%
switch lower(mode)
    
    case 'ellipse'
        
        limbRadius = 0.15;
        limbColour = 0.7*ones(1,3);
        M = repmat(limbColour,length(indices),1);
        plot3(shape(1,:),shape(3,:),shape(2,:),'.');
        hold on
        
        for i = 1:length(indices)
            
            P1 = [shape(1,I(i)) shape(3,I(i)) shape(2,I(i))];
            P2 = [shape(1,J(i)) shape(3,J(i)) shape(2,J(i))];
            P = 0.5*(P1 + P2);
            U = [ null(P1 - P2)'; (P1 -P2)/norm(P1-P2)];
            S = eye(3); S(1,1) = 1.5*norm(P1-P2);
            l = 0.55*norm(P1-P2);
            [x,y,z] = ellipsoid(0,0,0,limbRadius,limbRadius,l,8);
            axis equal;
            xv =x(:);
            yv = y(:);
            zv = z(:);
            newXYZ = U'*[xv';yv';zv'];
            xnew = reshape(newXYZ(1,:)+P(1),size(x,1),size(x,2));
            ynew = reshape(newXYZ(2,:)+P(2),size(x,1),size(x,2));
            znew = reshape(newXYZ(3,:)+P(3),size(x,1),size(x,2));
            
            handle = patch(surf2patch(xnew,ynew,znew));
            set(handle,'EdgeColor',[0.3 0.3 0.3],'EdgeAlpha',0.1);
            set(handle,'FaceLighting','phong','AmbientStrength',0.6);
            set(handle,'FaceColor', M(i,:));
            set(handle,'BackfaceLighting','lit');
            
        end
        
    case 'stick'
        
        linewidth = 1.5;
        for i = 1:length(indices)
            plot3(shape(1,[I(i),J(i)]),shape(3,[I(i),J(i)]),shape(2,[I(i),J(i)]),...
                '-','LineWidth',linewidth,'color',skel.tree(I(i)).color);
            hold on
        end
        
    otherwise
        fprintf('mode should be either ellipse or stick!\n');
        
end

%%
axis equal
grid on;
if flagShowCam
    drawCam(eye(3),[0;0;-2]);
end
view(viewpoint);

end

function S = normalizeS(S)
S = S / mean(std(S, 1, 2));
S = S - mean(S,2)*ones(1,size(S,2));
end

function drawCam(R,t)

scale = 0.5;
P = scale*[0 0 0;0.5 0.5 0.8; 0.5 -0.5 0.8; -0.5 0.5 0.8;-0.5 -0.5 0.8];

P1=R'*(P'+repmat(t,[1,5]));
P1=P1';

line([P1(1,1) P1(2,1)],[P1(1,3) P1(2,3)],[P1(1,2) P1(2,2)],'color','k')
line([P1(1,1) P1(3,1)],[P1(1,3) P1(3,3)],[P1(1,2) P1(3,2)],'color','k')
line([P1(1,1) P1(4,1)],[P1(1,3) P1(4,3)],[P1(1,2) P1(4,2)],'color','k')
line([P1(1,1) P1(5,1)],[P1(1,3) P1(5,3)],[P1(1,2) P1(5,2)],'color','k')

line([P1(2,1) P1(3,1)],[P1(2,3) P1(3,3)],[P1(2,2) P1(3,2)],'color','k')
line([P1(3,1) P1(5,1)],[P1(3,3) P1(5,3)],[P1(3,2) P1(5,2)],'color','k')
line([P1(5,1) P1(4,1)],[P1(5,3) P1(4,3)],[P1(5,2) P1(4,2)],'color','k')
line([P1(4,1) P1(2,1)],[P1(4,3) P1(2,3)],[P1(4,2) P1(2,2)],'color','k')


C1=[P1(2,1) P1(2,3) P1(2,2)];
C2=[P1(3,1) P1(3,3) P1(3,2)];
C3=[P1(4,1) P1(4,3) P1(4,2)];
C4=[P1(5,1) P1(5,3) P1(5,2)];

O=[P1(1,1) P1(1,3) P1(1,2)];
Cmid =0.25*(C1+C2+C3+C4);

Lz = [O; O+0.5*(Cmid-O)];
Lx = [O; O+0.5*(C1-C3)];
Ly = [O; O+0.5*(C1-C2)];

line(Lz(:,1),Lz(:,2),Lz(:,3),'color','b','linewidth',2)
line(Lx(:,1),Lx(:,2),Lx(:,3),'color','g','linewidth',2)
line(Ly(:,1),Ly(:,2),Ly(:,3),'color','r','linewidth',2)

axis tight;

end

function connection = skelConnectionMatrix(skel)

connection = zeros(length(skel.tree));
for i = 1:length(skel.tree);
    for j = 1:length(skel.tree(i).children)
        connection(i, skel.tree(i).children(j)) = 1;
    end
end

end


