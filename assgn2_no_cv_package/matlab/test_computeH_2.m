cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');

[locs1, locs2] = matchPics(cv_cover, cv_desk);

H = computeH_norm(locs2, locs1);


tform = projective2d(H);

J = imwarp(cv_desk, tform);

figure; imshow(J);