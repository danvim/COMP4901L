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

% save extrinsic parameters for dense reconstruction
%save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
