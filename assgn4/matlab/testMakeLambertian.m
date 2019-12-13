im = im2double(imread('../data/fruitbowl.png'));
s = [0.6257 0.5678 0.5349];
imout = makeLambertian(im,s);
imshow(mat2gray(imout));
