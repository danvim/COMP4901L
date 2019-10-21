function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

%% Normalize pts

n1 = pts1 / M;
n2 = pts2 / M;

%% Calculate Rank 3 F

u = n1(:, 1);
v = n1(:, 2);
x = n2(:, 1);
y = n2(:, 2);

A = [u.*x u.*y u v.*x v.*y v x y ones(size(u))];

[~, ~, V] = svd(A);

F3 = reshape(V(:, end), 3, 3)';

%% Calculate Rank 2 F

[O, P, Q] = svd(F3);

P(end, end) = 0;

F2 = O * P * Q';

%% Refine solution

FR = refineF(F2, n1, n2);

%% Un-normalize F

S = [
    1/M 0 0;
    0 1/M 0;
    0 0 1;
    ];

F = S' * FR * S;