function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%

figure;
subplot(121);
imshow(im2);
title('Inliers and Epipolar Lines in First Image'); hold on;
plot(pts1,'go')
epiLines = epipolarLine(F',pts1);
points = lineToBorderPoints(epiLines,size(im1));
line(points(:,[1,3])',points(:,[2,4])');
