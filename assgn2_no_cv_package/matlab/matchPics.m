function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if isequal(size(size(I1)), [1, 3])
    I1 = rgb2gray(I1);
end
if isequal(size(size(I2)), [1, 3])
    I2 = rgb2gray(I2);
end

%% Detect features in both images
f1 = fast_corner_detect_9(I1, 52);
f2 = fast_corner_detect_9(I2, 52);

%% Obtain descriptors for the computed feature locations
[d1, l1] = computeBrief(I1, f1);
[d2, l2] = computeBrief(I2, f2);

%% Match features using the descriptors
indexPairs = customMatchFeatures(d1, d2, 50);
idx1 = indexPairs(:,1);
idx2 = indexPairs(:,2);

locs1 = l1(idx1,:);
locs2 = l2(idx2,:);

end

