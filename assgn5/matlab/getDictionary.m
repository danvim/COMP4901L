function [dictionary] = getDictionary(imgPaths, alpha, K, method)
    if method ~= 'random' and method ~= 'harris'
        error('method must be random or harris');
    end
    [~,T] = size(imgPaths);
    FB = createFilterBank();
    [n,~] = size(FB);
    PR = zeros(alpha*T, 3*n); % pixel response
    for t = 1:T
        disp(t);
        path = imgPaths(t);
        I = imread(join(['../data/',path{1}]));
        filterResponses = extractFilterResponses(I, FB);
        if method == 'random'
            P = getRandomPoints(I,alpha);
        else
            P = getHarrisPoints(I,alpha,0.06);
        end
        P = floor(P);
        for i=1:(3*n)
            for j = 1:alpha
                x1 = P(j,1);
                x2 = P(j,2);
                PR(j+(t-1)*alpha,i) = filterResponses(x2,x1,i);
            end
        end
    end
    [~, dictionary] = kmeans(PR, K, 'EmptyAction', 'drop');
