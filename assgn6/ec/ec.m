% foreground background threshold, [0,1]
threshold = 0.7;
addpath('../images')
addpath('../matlab')
paths={
'image1.JPG'
'image2.JPG'
'image3.png'
'image4.jpg'
};

layers = get_lenet();
load lenet.mat

for pp = 1:length(paths)
path = paths{pp};
% path to image to be classified
%path = '../images/image1.JPG';

im = imread(path);
figure;
imshow(im);
[h,w,c] = size(im);
if c == 3
im = rgb2gray(im);
end
if max(im(:)) > 1
im = im ./ 255;
end
bw = zeros(h,w);
bw(im<threshold) = 1;

%imshow(bw);

CC = bwconncomp(bw);
n = CC.NumObjects;
layers{1}.batch_size = 1;
skip = 0;
identified = '';
for c = 1:n
    idx = CC.PixelIdxList{c};
    x = mod(idx, h);
    y = floor(idx / h);
    x0 = min(x)-1;
    y0 = min(y)-1;
    x1 = max(x)+1;
    y1 = max(y)+1;
    ww = x1-x0+1;
    hh = y1-y0+1;
    if ww<15 & hh<15
        skip = skip+1;
        continue;
    end
    wh = max(ww,hh);
%    if ww/hh>4 | hh/ww>4
        ii = zeros(wh,wh);
        ii((1:ww)+floor((wh-ww)/2),(1:hh)+floor((wh-hh)/2)) = bw(x0:x1, y0:y1);
%    else
%        ii = bw(x0:x1, y0:y1);
%    end
    ii = imresize(ii,[20 20]);
    iii = zeros(28,28);
    iii(5:24,5:24) = ii;
    X = reshape(iii',[28*28,1]);
    [output, P] = convnet_forward(params, layers, X);
    [p,y]=max(P);
    y=y-1;
    identified = sprintf("%s %i",identified,y);

%    figure;
%    imshow(iii);
    rectangle('Position', [y0, x0, hh, ww],'EdgeColor','r', 'LineWidth', 1)
    text(y0, x0-4, sprintf('%i (%0.2f)',y,p), 'FontSize', 4, 'BackgroundColor','r', 'Margin',1);
end
    drawnow;
fprintf('%s contains %i numbers: %s\n',path,n-skip, identified);
saveas(gcf,sprintf('../saved_figures/%s.jpg',path));
end
