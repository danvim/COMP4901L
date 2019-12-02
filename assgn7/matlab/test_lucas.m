A = imread('../data/landing/frame0190_crop.jpg');
B = imread('../data/landing/frame0194_crop.jpg');

px = 453;
py = 226;
ww = 20;

figure;
imshow(A(py-ww:py+ww-1, px-ww:px+ww-1));
title('Source Patch');

[u, v] = LucasKanade(A, B, [px-ww, py-ww, ww*2, ww*2]);

u_ = floor(u);
v_ = floor(v);

figure;
imshow(B(py+v_-ww:py+v_+ww-1, px+u_-ww:px+u_+ww-1));
title('Target Patch');
