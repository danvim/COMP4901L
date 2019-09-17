function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
%Your implementation here
% rhoScale and thetaScale are the arrays of ? and ? values
% H(i,j) contains the votes for ? = ?i and ? = ?i

[h,w] = size(Im);
M = ceil(sqrt(h^2 + w^2));
rhoScale = 0:rhoRes:M;
thetaScale = 0:thetaRes:2*pi;
[Y, X] = find(Im >= threshold);
%Y = Y-1;
%X = X-1;

[~,nRho] = size(rhoScale);
[~,nTheta] = size(thetaScale);
[nPoints,] = size(Y);

rhos = [X,Y] * [cos(thetaScale); sin(thetaScale)];
%rhos(rhos<0) = 0;
% disp(rhos);

rhos = max(rhos,0);
rhosidx = ceil((rhos) / rhoRes);
% disp(rhosidx);

H = zeros(nRho, nTheta);
for i = 1:nPoints
    for t = 1:nTheta
        if rhosidx(i,t) == 0
            continue
        end
        H(rhosidx(i,t),t) = H(rhosidx(i,t),t)+1;
    end
end
%imshow(H/max(H(:)));
end        
        