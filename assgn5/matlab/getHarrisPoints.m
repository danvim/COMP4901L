function [P] = getHarrisPoints(I, a, k)
    s = 3; %gradient window size
%    I = double(I);
    if size(I,3) == 3
        I = rgb2gray(I);
    end
    I = double(I);
    [h,w] = size(I);

    [Ix,Iy] = gradient(I);
    [Ixx,Ixy] = gradient(Ix);
    [Iyx,Iyy] = gradient(Iy);

    one = ones(s,s);
    Ixx = conv2(Ixx,one,'same');
    Ixy = conv2(Ixy,one,'same');
    Iyx = conv2(Iyx,one,'same');
    Iyy = conv2(Iyy,one,'same');

    H = (Ixx .* Iyy - Iyx .* Ixy) - k*(Ixx + Iyy).^2;
    [~,p] = sort(H(:),'descend');
    p = p(1:a);
    P = zeros(a,2);
    P(:,1) = floor(p/h);
    P(:,2) = mod(p,h);

%    figure;
    imshow(mat2gray(H));
%    hold on;
%    plot(P(:,1),P(:,2),'ro');
%    hold off;
