% A test script using templeCoords.mat
%
% Write your code here
%

load('../data/someCorresp.mat');
load('../data/intrinsics.mat');
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');

F = eightpoint(pts1, pts2, M);

% displayEpipolarF(I1, I2, F);

% epipolarMatchGUI(I1, I2, F);

E = essentialMatrix(F, K1, K2);


P1 = [
    1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    ];

Ex2s = camera2(E);
[N,~] = size(pts1);
for i = 1:4
    figure;
    P2 = Ex2s(:,:,i);
    X = triangulate(P1, pts1, P2, pts2);
    x1 = P1 * [X ones(N,1)]';
    p1err = norm(pts1' - x1(1:2, :)./x1(3,:));
    disp('p1err');
    disp(p1err);

    x2 = P2 * [X ones(N,1)]';
    p2err = norm(pts2' - x2(1:2, :)./x2(3,:));
    disp('p2err');
    disp(p2err);
    scatter3(X(:,1), X(:,2),X(:,3));
end

% save extrinsic parameters for dense reconstruction
%save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
