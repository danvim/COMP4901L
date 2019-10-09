function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
x1 = double(x1);
x2 = double(x2);

%% Estimate normalized homography H
n1x = x1(:,1);
n1y = x2(:,2);
n2x = x1(:,1);
n2y = x2(:,2);

[len, ~] = size(n1x);

o = ones([len, 1]);
z3 = zeros([len, 3]);

A = [
    -n2x -n2y -o z3 n1x.*n2x n1x.*n2y n1x;
    z3 -n2x -n2y -o n1y.*n2x n1y.*n2y n1y
    ];

H2to1 = A \ zeros([len*2, 1]);

end
