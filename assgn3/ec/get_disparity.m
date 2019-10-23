function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

[H,W,~] = size(im2);

dispM = Inf(H,W);
scoreM = Inf(H,W);

for d = 0:maxDisp
    I2 = padarray(im2, [0, d], 'replicate', 'pre');
    I2 = I2(1:H,1:W,:);
    D = im1 - I2;
    D = D.^2;
    D = conv2(D(:,:), ones(windowSize),'same');
%    if d == 5
%    disp(size(D));
%    imshow(mat2gray(D));
%    sfegesf;
%    end
%    D(:,:,1) = conv2(D(:,:,1), ones(windowSize),'same');
%    D(:,:,2) = conv2(D(:,:,2), ones(windowSize),'same');
%    D(:,:,3) = conv2(D(:,:,3), ones(windowSize),'same');
%    D = double(D(:,:,1)+D(:,:,2)+D(:,:,3));
    Idx = D<scoreM;
    dd = d*ones(H,W);
    dispM(Idx) = dd(Idx);
    scoreM = min(scoreM, D);
end
