function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

%pts1(:,1) /= M;
%pts2(:,1) /= M;
%pts1(:,2) /= M;
%pts2(:,2) /= M;

F = estimateFundamentalMatrix(pts1, pts2);

