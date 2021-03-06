function [H2to1] = computeH_norm(X1, X2)
SQ_2 = sqrt(2);

%% Compute centroids of the points
x1_mean = mean(X1);
x2_mean = mean(X2);

%% Shift the origin of the points to the centroid
t1 = X1 - x1_mean;
t2 = X2 - x2_mean;

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
d1 = sqrt(t1(:,1).^2 + t1(:,2).^2);
d2 = sqrt(t2(:,1).^2 + t2(:,2).^2);

m1 = max(d1);
m2 = max(d2);

if m1 ~= 0
    s1 = SQ_2 / m1;
    n1 = t1 * s1;
else
    s1 = 0;
    n1 = t1;
end
if m2 ~= 0
    s2 = SQ_2 / m2;
    n2 = t2 * s2;
else
    s2 = 0;
    n2 = t2;
end

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
H = computeH(n1, n2);

%% Denormalization
H2to1 = T1 \ H * T2;
