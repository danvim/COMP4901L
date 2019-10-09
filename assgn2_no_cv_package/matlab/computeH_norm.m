function [H2to1] = computeH_norm(x1, x2)
SQ_2 = sqrt(2);

%% Compute centroids of the points
x1_mean = mean(x1);
x2_mean = mean(x2);

%% Shift the origin of the points to the centroid
t1 = x1 - x1_mean;
t2 = x2 - x2_mean;

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
d1 = sqrt(t1(:,1).^2 + t1(:,2).^2);
d2 = sqrt(t2(:,1).^2 + t2(:,2).^2);

m1 = max(d1);
m2 = max(d2);

s1 = SQ_2 / m1;
s2 = SQ_2 / m2;

n1 = t1 * s1;
n2 = t2 * s2;

%% similarity transform 1
Tt1 = [
    1 0 -x1_mean(1);
    0 1 -x1_mean(2);
    0 0 1
];
Ts1 = [
    s1 0 0;
    0 s1 0;
    0 0 1
];
T1 = Ts1 * Tt1;

%% similarity transform 2
Tt2 = [
    1 0 -x2_mean(1);
    0 1 -x2_mean(2);
    0 0 1
];
Ts2 = [
    s2 0 0;
    0 s2 0;
    0 0 1
];
T2 = Ts2 * Tt2;

%% Compute Homography
H = computeH(n2, n1);

%% Denormalization
H2to1 = T1 \ H * T2;
