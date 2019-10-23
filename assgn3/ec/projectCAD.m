load('../data/PnP.mat');
[~,N] = size(X);
P = estimate_pose(x,X);
PX = P*[X;ones(1,N)];
PX = PX(1:2,:) ./ PX(3,:);

figure;
subplot(1,3,1);
imshow(image);
hold;
plot(x(1,:),x(2,:),'rx');
plot(PX(1,:),PX(2,:),'gO');

subplot(1,3,2);
[K,R,T] = estimate_params(P);
V = cad.vertices';
RV = R*V;
trimesh(cad.faces,RV(1,:),RV(2,:),RV(3,:));
hold off;

subplot(1,3,3);
imshow(image);
hold;
V = cad.vertices';
[~,N] = size(V);
PV = P*[V;ones(1,N)];
PV = PV(1:2,:) ./ PV(3,:);
patch('Faces',cad.faces,'Vertices',PV','FaceColor',[1,0,0]);
hold off;
