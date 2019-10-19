% A test script using templeCoords.mat
%
% Write your code here
%

% save extrinsic parameters for dense reconstruction

% 1. load data
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
load('../data/someCorresp.mat');
figure;
showMatchedFeatures(im1,im2,pts1,pts2,'montage','PlotOptions',{'ro','go','y--'});
title('all given points');

% 2. compute fundamental matrix
%F = eightpoint(pts1, pts2, M);
[F, inliers] = estimateFundamentalMatrix(pts1,pts2,'NumTrials',2000);
%figure;
%showMatchedFeatures(im1, im2, pts1(inliers,:),pts2(inliers,:),'montage','PlotOptions',{'ro','go','y--'});
%title('Point matches after outliers were removed');

% 3. compute epipolar correspondence
%load('../data/templeCoords.mat');
%pts2 = epipolarCorrespondence(im1,im2,F,pts1);
%I1 = rgb2gray(im1);
%I2 = rgb2gray(im2);
%pts1 = detectHarrisFeatures(I1);
%pts2 = detectHarrisFeatures(I2);
%[features1,valid_points1] = extractFeatures(I1,pts1);
%[features2,valid_points2] = extractFeatures(I2,pts2);
%indexPairs = matchFeatures(features1,features2);
%pts1 = valid_points1(indexPairs(:,1),:);
%pts2 = valid_points2(indexPairs(:,2),:);
%figure; showMatchedFeatures(im1,im2,pts1,pts2);

% 4. comput essential matrix
load('../data/intrinsics.mat');
E = essentialMatrix(F,K1,K2);
%E = F;

% 5. comput camera matrix
P1 = [1 0 0 0; 0 1 0 0; 0 0 1 0];
M2s = camera2(E);
disp(M2s);

pts3d1 = mytriangulate(P1, pts1, M2s(:,:,1), pts2);
figure;
plot3(pts3d1(:,1), pts3d1(:,2), pts3d1(:,3),'.');
title('1');

pts3d2 = mytriangulate(P1, pts1, M2s(:,:,2), pts2);
figure;
plot3(pts3d2(:,1), pts3d2(:,2), pts3d2(:,3),'.');
title('2');

pts3d3 = mytriangulate(P1, pts1, M2s(:,:,3), pts2);
figure;
plot3(pts3d3(:,1), pts3d3(:,2), pts3d3(:,3),'.');
title('3');

pts3d4 = mytriangulate(P1, pts1, M2s(:,:,4), pts2);
figure;
plot3(pts3d4(:,1), pts3d4(:,2), pts3d4(:,3),'.');
title('4');

save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
