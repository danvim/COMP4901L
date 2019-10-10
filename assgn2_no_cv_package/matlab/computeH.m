function [ H2to1 ] = computeH( X1, X2 )
%COMPUTEH Computes the homography between two sets of points
X1 = double(X1);
X2 = double(X2);

%% Estimate normalized homography H
x1 = X1(:,1);
y1 = X1(:,2);
x2 = X2(:,1);
y2 = X2(:,2);

[len, ~] = size(x1);

o = ones([len, 1]);
z3 = zeros([len, 3]);

A = [
    -x2   -y2   -o   z3               x1.*x2   x1.*y2   x1;
    z3               -x2   -y2   -o   y1.*x2   y1.*y2   y1
    ];

[~, ~, V] = svd(A);

H2to1 = reshape(V(:, end), 3, 3)';

end
