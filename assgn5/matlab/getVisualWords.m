function [wordMap] = getVisualWords(I, FB, dict)
    [h,w,~] = size(I);
    [n,~] = size(FB);
    [K,~] = size(dict);
    FR = extractFilterResponses(I, FB);
    wordMap = zeros(h,w);
    D = inf(h,w);
    for k = 1:K
        p = reshape(dict(k,:), 1,3*n);
        for i = 1:h
            r = reshape(FR(i,:,:), w,3*n);
            d = pdist2(p, r);
            idx = d < D(i,:);
            D(i,idx) = d(idx);
            wordMap(i,idx) = k;
        end
    end
    wordMap = reshape(wordMap, h, w);
