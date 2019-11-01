% hist1 size: 1 * K
% hist2 size: n * K
% dists size: n * 1
function dists = getImageDistance(hist1, histSet, method)

[n, ~] = size(histSet);
dists = zeros([n, 1]);

switch method
    case "euclidean"
        hist1s = repmat(hist1, n, 1);
        dists = sqrt(sum((hist1s - histSet).^2, 2));
    case "chi2"
        m = size(hist1,1);
        mOnes = ones(1,m);
        for j=1:n
            hist2 = histSet(j,:);
            n = size(hist2,1);
            D = zeros(m,n);
            for i=1:n
              yi = hist2(i,:);
              yiRep = yi( mOnes, : );
              D(:,i) = sum( (yiRep - hist1).^2 ./ (yiRep + hist1 + eps), 2 );
            end
            dists(j,:) = D/2;
        end
end

end