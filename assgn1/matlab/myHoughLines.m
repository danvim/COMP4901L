function [rhos, thetas] = myHoughLines(H, nLines)
%Your implemention here
rhos = zeros(nLines,1);
thetas = zeros(nLines,1);
[h,w] = size(H);
for i = 1:nLines
    [rs, ts] = find(H == max(H(:)));
    rho = rs(1);
    theta = ts(1);
    H(max(rho-2,1):min(rho+2,h), max(theta-2,1):min(theta+2,w)) = 0;
    rhos(i) = rho;
    thetas(i) = theta;
end
end
        