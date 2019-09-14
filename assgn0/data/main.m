img = imread("banana_slug.tiff");

[H, W] = size(img);

% grbg rggb bggr gbrg
%igrbg = demosaic(img*4,'grbg');
%irggb = demosaic(img*4,'rggb');
%ibggr = demosaic(img*4,'bggr');
%igbrg = demosaic(img*4,'gbrg');


% rggb is the best
%img = irggb;
%% Linearization
img = double(img);

% linear
img = (img-2047) / (15000 - 2047);
img = max(0,img);
img = min(img,1);

%% Bayer pattern rggb
im1 = img(1:2:end, 1:2:end);
im2 = img(1:2:end, 2:2:end);
im3 = img(2:2:end, 1:2:end);
im4 = img(2:2:end, 2:2:end);

igrbg = cat(3, im2, im1, im3);
irggb = cat(3, im1, im2, im4);
ibggr = cat(3, im4, im2, im1);
igbrg = cat(3, im3, im1, im2);

figure;imshow(igrbg*4);title('grbg');
figure;imshow(irggb*4);title('rggb');
figure;imshow(ibggr*4);title('bggr');
figure;imshow(igbrg*4);title('gbrg');

% rggb is the best
img = irggb;
r = im1;
g = (im2 + im3)/2;
b = im4;

%% White Balancing
r_ = mean(r);
g_ = mean(g);
b_ = mean(b);

r1 = g_/r_ * r;
g1 = g;
b1 = g_/b_ * b;

rmax = max(r);
gmax = max(g);
bmax = max(b);

r2 = gmax / rmax * r;
g2 = g;
b2 = gmax / bmax * b;

% gray world assumption
gwa = cat(3, r1,g1,b1);
% white world assuption
wwa = cat(3,r2,g2,b2);

figure;imshow(gwa*4);title('gwa');
figure;imshow(wwa*4);title('wwa');

% wwa looks better

%% Interpolation 

% rggb
to_interp = zeros([H,W]);
to_interp(1:2:end, 1:2:end) = r2;
to_interp(1:2:end, 2:2:end) = g2;
to_interp(2:2:end, 1:2:end) = g2;
to_interp(2:2:end, 2:2:end) = b2;

%%
R = zeros([H,W]);
[RX, RY] = meshgrid(1:2:W, 1:2:H);
[X,Y]=meshgrid(1:2:W, 2:2:H);
R(1:2:end, 2:2:end) = interp2(RX,RY,r2, X, Y);
[X,Y]=meshgrid(2:2:W, 2:2:H);
R(2:2:end, 2:2:end) = interp2(RX,RY,r2, X, Y);
[X,Y]=meshgrid(2:2:W, 1:2:H);
R(2:2:end, 1:2:end) = interp2(RX,RY,r2, X, Y);
[X,Y]=meshgrid(1:2:W, 1:2:H);
R(1:2:end, 1:2:end) = interp2(RX,RY,r2, X, Y);


G = zeros([H,W]);
[GX, GY] = meshgrid(2:2:W, 1:2:H);
[X,Y]=meshgrid(1:2:W, 2:2:H);
G(1:2:end, 2:2:end) = interp2(GX,GY,g2, X, Y);
[X,Y]=meshgrid(2:2:W, 2:2:H);
G(2:2:end, 2:2:end) = interp2(GX,GY,g2, X, Y);
[X,Y]=meshgrid(2:2:W, 1:2:H);
G(2:2:end, 1:2:end) = interp2(GX,GY,g2, X, Y);
[X,Y]=meshgrid(1:2:W, 1:2:H);
G(1:2:end, 1:2:end) = interp2(GX,GY,g2, X, Y);

B = zeros([H,W]);
[BX, BY] = meshgrid(2:2:W, 1:2:H);
[X,Y]=meshgrid(1:2:W, 2:2:H);
B(1:2:end, 2:2:end) = interp2(BX,BY,b2, X, Y);
[X,Y]=meshgrid(2:2:W, 2:2:H);
B(2:2:end, 2:2:end) = interp2(BX,BY,b2, X, Y);
[X,Y]=meshgrid(2:2:W, 1:2:H);
B(2:2:end, 1:2:end) = interp2(BX,BY,b2, X, Y);
[X,Y]=meshgrid(1:2:W, 1:2:H);
B(1:2:end, 1:2:end) = interp2(BX,BY,b2, X, Y);

iRGB = cat(3,R,G,B);
figure;imshow(iRGB*4);title('interpolated');

%% Brightness
ig = rgb2gray(iRGB);
ibright = iRGB * 4 * max(ig(:));
%figure;imshow(iscale);title('scaled');

igama = zeros(size(ibright));
inds = (ibright <= 0.0031308);
igama(inds) = 12.92 * ibright(inds);
igama(~inds) = 1.055 * ibright(~inds) .^ (1 / 2.4) - 0.055;

figure; imshow(igama);
imwrite(igama, "final.JPG");