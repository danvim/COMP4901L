function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
SQ_2 = sqrt(2);

x1 = double(x1);
x2 = double(x2);

%% 1. Get mean of points and translate x1 and x2 mean to origin
x1_mean = mean(x1);
x2_mean = mean(x2);

t1 = x1 - x1_mean;
t2 = x2 - x2_mean;
% Save transformation
Tt1 = [
    1 0 -x1_mean(1);
    0 1 -x1_mean(2);
    0 0 1
];
Tt2 = [
    1 0 -x2_mean(1);
    0 1 -x2_mean(2);
    0 0 1
];

%% 2. Get largest distance and scale all points to max of sqrt(2)
d1 = sqrt(t1(:,1).^2 + t1(:,2).^2);
d2 = sqrt(t2(:,1).^2 + t2(:,2).^2);

m1 = max(d1);
m2 = max(d2);

s1 = SQ_2 / m1;
s2 = SQ_2 / m2;

n1 = t1 * s1;
n2 = t2 * s2;
% Save transformation
Ts1 = [
    s1 0 0;
    0 s1 0;
    0 0 1
];
Ts2 = [
    s2 0 0;
    0 s2 0;
    0 0 1
];
T1 = Ts1 * Tt1;
T2 = Ts2 * Tt2;
T1_ = inv(T1);
T2_ = inv(T2);

%% Estimate normalized homography H


end
