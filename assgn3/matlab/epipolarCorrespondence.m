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

p1h = [pts1, ones([length(pts1), 1])];
l = (F * p1h')';

[h, w] = size(im1);

%% Search window along line

G = [
    1 2 1;
    2 4 2;
    1 2 1;
    ];

I1 = padarray(im1, [1, 1], 'replicate', 'both');
I2 = padarray(im2, [1, 1], 'replicate', 'both');

pts2 = [];

for i = 1:length(pts1)
    pos = pts1(1, :);
    x = pos(1);
    y = pos(2);
    W = im1(x:x+3, y:y+3); % Source window
    % Search through line: ax + by + c = 0 iterate y
    ys = 1:h; % x = (-by - c)/a
    xs = -(W(2) * ys - W(3)) / W(1);
    ts = [xs ys]; % target
    
end
