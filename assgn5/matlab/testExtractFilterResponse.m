I = loadImage();
B = createFilterBank();
R = extractFilterResponses(I,B);
figure;
imshow(mat2gray([R(:,:,1), R(:,:,2), R(:,:,3)]));
figure;
imshow(mat2gray([R(:,:,16), R(:,:,17), R(:,:,18)]));
figure;
imshow(mat2gray([R(:,:,31), R(:,:,32), R(:,:,33)]));

