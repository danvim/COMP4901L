% A test script using templeCoords.mat
%
% Write your code here
%

%% 1. Load all those rubbish
load('../data/someCorresp.mat');
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');

%% 2. Calculate the rubbish F matrix
F = eightpoint(pts1, pts2, M);
% F = estimateFundamentalMatrix(pts1, pts2, 'Method', 'Norm8Point');

%% 3. Calculate the stupid correspondance
load('../data/templeCoords.mat');
%disp(size(pts1));
pts2 = epipolarCorrespondence(I1, I2, F, pts1);

% displayEpipolarF(I1, I2, F);

% epipolarMatchGUI(I1, I2, F);

%% 4. calculate the stupid essential matrix
load('../data/intrinsics.mat');
E = essentialMatrix(F, K1, K2);
% E = [-0.0024 0.1524 0.0231; 0.1091 -0.0043 -1.0004; 0.0007 1.0132 0.0012];

%% 5. P1 and candidates for P2
Ex1 = [
    1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    ];
P1 = K1*Ex1;

Ex2s = camera2(E);

%% 6 seee which P2 is good
[N,~] = size(pts1);
for i = 1:4
    figure;
    P2 = K2*Ex2s(:,:,i);
    X = triangulate(P1, pts1, P2, pts2);
    x1 = P1 * [X ones(N,1)]';
    x1 = x1(1:2, :)./x1(3,:);
    d = (pts1' - x1).^2;
    p1err = sum(sqrt(d(1,:)+d(2,:))) / N;
    disp('p1err');
    disp(p1err);

    x2 = P2 * [X ones(N,1)]';
    x2 = x2(1:2, :)./x2(3,:);
    d = (pts2' - x2).^2;
    p2err = sum(sqrt(d(1,:)+d(2,:))) / N;
    disp('p2err');
    disp(p2err);
    plot3(X(:,1), X(:,2),X(:,3),'.');
end

%% 7 save extrinsic parameters for dense reconstruction
%save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
