
% precision: size of interval in degree
function [h] = hog(I, precision)
    n = 360/precision;
    I = double(I)/double(max(I(:)));
    [Ix, Iy] = gradient(I);
    D = mod(floor((atan2(Iy,Ix))/pi*180/precision), n)+1;

    h = zeros(1, n);
    for i = 1:n
        h(1, i) = sum(sum(D == i));
    end
    [H,W] = size(I);
    h = h/(H*W);
