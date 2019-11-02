function [wordMap] = getVisualWords(I, FB, dict)
[h,w,~] = size(I);
[n,~] = size(FB);
[K,~] = size(dict);
FR = extractFilterResponses(I, FB);
size(FR)
%FR = reshape(FR, h*w, 3*n);
wordMap = zeros(h,w);
D = inf(h,w);
for k = 1:K
    p = reshape(dict(k,:), 1,3*n);
    for i = 1:h
        for j = 1:w
            r = reshape(FR(i,j,:), 1,3*n);
%            size(p)
%            size(r)
            d = pdist2(p, r);
%            size(d)
            if d < D(i,j)
                D(i,j) = d;
                wordMap(i,j) = k;
            end
        end
    end
%    d = pdist2(dict(k,:), FR);
%    wordMap(d<D) = k;
%    D(d<D) = d;
end
wordMap = reshape(wordMap, h, w);
