function [P] = getRandomPoints(I, a)
    [H,W,~] = size(I);
    P = rand(a,2);
    P(:,1) = P(:,1) .* W;
    P(:,2) = P(:,2) .* H;
