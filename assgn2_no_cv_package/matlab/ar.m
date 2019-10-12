% Q3.3.1

%% Read from movies
B = loadVid('../data/book.mov');
P = loadVid('../data/ar_source.mov');

%% Retrieve cover size ratio for cropping
cv_img = imread('../data/cv_cover.jpg');
[cvh, cvw] = size(cv_img);
ratio = cvh/cvw;

[ph, pw, ~] = size(P(1).cdata);
[bh, bw, ~] = size(B(1).cdata);

pandaBookW = ph / ratio;
startX = (pw - pandaBookW) / 2;
rect = [startX 0 pandaBookW ph];

%% Harry-Potterize each frame and write to movie
movie_obj = VideoWriter('../result/panda_book.mov');
open(movie_obj);
for i = 1 : length(P)
    i
    fP = imcrop(P(i).cdata, rect);
    fB = B(i).cdata;
    [locs1, locs2] = matchPics(cv_img, fB);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    pBook = imresize(fP, [cvh, cvw]) + 1;
    R = compositeH(inv(bestH2to1), pBook, fB);
    writeVideo(movie_obj, R);
end
close(movie_obj);