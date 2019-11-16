function [err] = rel_error(x,y)
    K = abs(x - y) ./ (max(1e-8*(ones(size(x))), abs(x) + abs(y)));
    err = max(K(:));
