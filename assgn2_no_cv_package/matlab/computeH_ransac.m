function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3

% T = 5000; % choosing p = 0.95 and e = 0.6. can tweak later on
% T = 13000; % choosing p = 0.95 and e = 0.65.
T = 100000;
[l, ~] = size(locs1);
d = 20;
inliersCount = 0;

minE = inf;
for t = 1:T
    % randomly sample 4 points with replacement
    ri = randperm(l, 4);
    Ht = computeH_norm(locs1(ri,:), locs2(ri,:));
    
    % compute inlier counts taking out the 8 points sampled
    % set some distance d and count the inliers
    
    locs1_ = (Ht * [locs2 ones([l, 1])]')'; 
    % compute SSD on euclidean distances
    dv = locs1_(:,1:2) - locs1;
    ds = abs(sqrt(dv(:,1).^2 + dv(:,2).^2));
    % these indices are inliers without the sampled points
    i = ds < d;
    i(ri) = false;
    iC = sum(i);
    sse = sum(ds(i) .^ 2);
    if iC > inliersCount || iC == inliersCount && sse < minE
        minE = sse;
        inliers = i;
        inliersCount = iC;
    end
end
% when best model is found, feed all inliers and find the homography
bestH2to1 = computeH_norm(locs1(inliers,:), locs2(inliers,:));
% bestH2to1 = Ht;

end

