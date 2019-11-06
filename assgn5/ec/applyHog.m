function [h] = applyHog(I, precision)
    n = 360/precision;

    [h,w,d] = size(I);
    if d == 1
        L = I;
        A = I;
        B = I;
    else
        [L, A, B] = RGB2Lab(I);
    end
    N = 3*n;
    h = zeros(1,N);
    h(1, 1:3:N) = hog(L,precision);
    h(1, 2:3:N) = hog(A,precision);
    h(1, 3:3:N) = hog(B,precision);
