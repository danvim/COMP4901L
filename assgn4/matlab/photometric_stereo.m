%% recalculate albedo and normal

I1 = im2double(rgb2gray(imread('../data/PhotometricStereo/female_01.tif')));
I2 = im2double(rgb2gray(imread('../data/PhotometricStereo/female_02.tif')));
I3 = im2double(rgb2gray(imread('../data/PhotometricStereo/female_03.tif')));
I4 = im2double(rgb2gray(imread('../data/PhotometricStereo/female_04.tif')));
I5 = im2double(rgb2gray(imread('../data/PhotometricStereo/female_05.tif')));
I6 = im2double(rgb2gray(imread('../data/PhotometricStereo/female_06.tif')));
I7 = im2double(rgb2gray(imread('../data/PhotometricStereo/female_07.tif')));

load('../data/PhotometricStereo/sources.mat');

[h,w] = size(I1);

a = zeros(h,w);
n = zeros(h,w,3);

for y = 1:h
    for x = 1:w
        b = S\[I1(y,x) I2(y,x) I3(y,x) I4(y,x) I5(y,x) I6(y,x) I7(y,x)]';
        a(y,x) = norm(b);
        n(y,x,:) = b./a(y,x);
    end
end

subplot(1,2,1);
imshow(a);
title('albedo');
subplot(1,2,2);
quiver(1:w,1:h,n(1:h,1:w,1),n(1:h,1:w,2));
set(gca, 'YDir','reverse');
title('normal');

%% render for different light source direction

figure;
subplot(1,2,1);
L = [0.58, -0.58, -0.58];
imshow(a.*max(0,n(:,:,1).*L(1)+n(:,:,2).*L(2)+n(:,:,3).*L(3)));
title('[0.58, -0.58, -0.58]');

subplot(1,2,2);
L = [-0.58, -0.58, -0.58];
imshow(a.*max(0,n(:,:,1).*L(1)+n(:,:,2).*L(2)+n(:,:,3).*L(3)));
title('[-0.58, -0.58, -0.58]');

%% reconstruct the 3D model

figure;
shading interp
s = surf(1:w, 1:h, -integrate_frankot(n), 'EdgeColor', 'none', 'FaceColor', 'interp');
title('reconstructed');

%material shiny;
light               % create a light
lighting gouraud    % preferred method for lighting curved surfaces
