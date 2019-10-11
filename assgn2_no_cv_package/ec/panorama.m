%Q2.2.4
clear all;
close all;

addpath('../matlab')

right_img = imread('../data/pano2_right.jpg');
left_img = imread('../data/pano2_left.jpg');

%% Extract features and match
[locs1, locs2] = matchPics(right_img, left_img);

%% Compute homography using RANSAC
[H, ~] = computeH_ransac(locs1, locs2);

%% Scale harry potter image to template size
% Why is this is important?
scaled_right_img = imresize(right_img, [size(right_img,1) size(right_img,2)]);

H_ = inv(H);

[w,h] = size(left_img);
disp(w);
disp(h);
X = H*[w,h,1]';
x0 = X(1)/X(3);
y0 = X(2)/X(3);

X = H*[0,h,1]';
x1 = X(1)/X(3);
y1 = X(2)/X(3);

X = H*[0,0,1]';
x2 = X(1)/X(3);
y2 = X(2)/X(3);

X = H*[w,0,1]';
x3 = X(1)/X(3);
y3 = X(2)/X(3);

minx = floor(min([x0,x1,x2,x3]));
maxx = floor(max([x0,x1,x2,x3]));
miny = floor(min([y0,y1,y2,y3]));
maxy = floor(max([y0,y1,y2,y3]));

disp([minx, maxx, miny, maxy]);

w = max([w,maxx])-minx;
h = max([h,maxy])-miny;

disp(w);
disp(h);

scaled_right_img = padarray(scaled_right_img,[-miny,0],0,'pre');
scaled_right_img = padarray(scaled_right_img,[abs(maxy-h),abs(maxx-w)],0,'post');

left_img = padarray(left_img,[-miny,0],0,'pre');
left_img = padarray(left_img,[abs(maxy-h),abs(maxx-w)],0,'post');

%% Display warped image.
imshow(warpH(scaled_right_img, inv(H), [w,h]));

%% Display composite image
imshow(compositeH(inv(H), scaled_right_img, left_img));
