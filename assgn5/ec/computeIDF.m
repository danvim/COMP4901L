addpath('../matlab');
load("../data/traintest.mat");
load("visionSVM.mat");
[trainCount, K] = size(trainFeatures);

IDF = zeros(1, K);
for k=1:K
    o = length(find(trainFeatures(:,k)));
    IDF(k) = log(trainCount/o);
end

save("idf.mat", "IDF");