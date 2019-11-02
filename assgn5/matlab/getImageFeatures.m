function [h] = getImageFeatures(wordMap, dictionarySize)
    h = zeros(1,dictionarySize);
    for i = 1:dictionarySize
        h(1,i) = sum(sum(wordMap==i));
    end
    h = h ./ sum(h);
