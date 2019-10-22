function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]
x1 = x(1,:)';
x2 = x(2,:)';

[~,N] = size(x);

X1 = X(1, :)';
X2 = X(2, :)';
X3 = X(3, :)';

o = ones(N,1);
z = zeros(N,1);

Ax1 = [-X1, -X2, -X3, -o,   z,   z,   z,  z, x1.*X1, x1.*X2, x1.*X3, x1];
Ax2 = [  z,   z,   z,  z, -X1, -X2, -X3, -o, x2.*X1, x2.*X2, x2.*X3, x2];

A = [Ax1; Ax2];

[~, ~, V] = svd(A);

P = reshape(V(:, end), 4, 3)';
