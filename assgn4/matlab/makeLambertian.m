function [imout] = makeLambertian(im,s)
A = null(s);
c1 = A(:,1);
c2 = A(:,2);
[h,w,~] = size(im);
imout = zeros(h,w);

for y = 1:h
    for x = 1:w
        C = reshape(im(y,x,:),[3,1]);
        a1 = dot(c1,C);
        a2 = dot(c2,C);
        imout(y,x) = sqrt(a1^2 + a2^2);
    end
end
%imout = mat2gray(imout);
