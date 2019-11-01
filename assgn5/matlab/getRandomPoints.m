function [P] = getRandomPoints(I, a)
    [H,W,~] = size(I);
    P = rand(a,2);
    o = ones(a,1);
    P(:,1) = max(o,min(P(:,1) .* W, o*W));
    P(:,2) = max(o,min(P(:,2) .* H, o*H));
