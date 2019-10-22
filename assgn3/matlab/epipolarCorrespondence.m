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

k = 7;

p1h = [pts1, 1];
l = (F * p1h')';

[h, w, ~] = size(im1);

%% Search window along line
padSize = (k-1)/2;
I1 = padarray(im1, [padSize, padSize], 'replicate', 'both');
I2 = padarray(im2, [padSize, padSize], 'replicate', 'both');

pos = pts1(1, :);
x = floor(pos(1));
y = floor(pos(2));
W = double(I1(y:y+k-1, x:x+k-1, :)); % Source window
% Search through line: ax + by + c = 0 iterate y
% y = (-a/b)x - (c/b)
m = -l(1)/l(2);
if m > 1 || m < -1
    ys = (1:h)'; % x = (-by - c)/a
    xs = floor(-(l(2) * ys + l(3)) / l(1));
else
    xs = (1:w)';
    ys = floor(-(l(1) * xs + l(3)) / l(2));
end
ts = [xs ys]; % target
scores = zeros([length(ts), 1]);
for j = 1:length(ts)
    pos_ = ts(j, :);
    x_ = pos_(1);
    y_ = pos_(2);
    if x_ < 1 || x_ > w || y_ < 1 || y_ > h
        continue
    end
    V = double(I2(y_:y_+k-1, x_:x_+k-1, :));
    scores(j) = sum(abs(W-V), 'all');
end
[~, bestI] = min(scores);
pts2 = ts(bestI, :);

