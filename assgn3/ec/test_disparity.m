im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
[h,w,~] = size(im1);
addpath('../matlab');
load('../data/intrinsics.mat', 'K1', 'K2');
load('../data/extrinsics.mat', 'R1', 'R2', 't1', 't2');
[M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = rectify_pair(K1,K2, R1,R2, t1,t2);
[rectIL1, rectIR1, bbL, bbR] = warp_stereo(im1(:,:,1), im2(:,:,1), M1, M2);
[rectIL2, rectIR2, bbL, bbR] = warp_stereo(im1(:,:,2), im2(:,:,2), M1, M2);
[rectIL3, rectIR3, bbL, bbR] = warp_stereo(im1(:,:,3), im2(:,:,3), M1, M2);
[H,W,~] = size(rectIL1);
rectIL = zeros(H,W,3);
rectIR = zeros(H,W,3);
rectIL(:,:,1) = rectIL1(:,:);
rectIL(:,:,2) = rectIL2(:,:);
rectIL(:,:,3) = rectIL3(:,:);
rectIR(:,:,1) = rectIR1(:,:);
rectIR(:,:,2) = rectIR2(:,:);
rectIR(:,:,3) = rectIR3(:,:);

rectIL = rectIL(1:h, (W-w+1):W, :);
rectIR = rectIR(1:h, 1:w, :);


maxDisp = 100;
windowSize = 7;
D = get_disparity(rectIL, rectIR, maxDisp, windowSize);
imshow(mat2gray(D));
