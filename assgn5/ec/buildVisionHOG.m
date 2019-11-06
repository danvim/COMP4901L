addpath('../matlab');

load("../data/traintest.mat");
[~, trainCount] = size(train_labels);
[~, testCount] = size(test_labels);

[~,T] = size(train_imagenames);
[~,t] = size(test_imagenames);

precision = 15;
n = 360/precision;
N = 3*n;

trainFeatures = zeros(T,N);
for i = 1:T
    imname = train_imagenames{i};
    I = imread(['../data/',imname]);
    if mod(i,100)==0
    disp([i,T]);
    end
%    disp(imname(1:end-3))
    trainFeatures(i,:) = applyHog(I,precision);
end

testFeatures = zeros(t,N);
for i = 1:t
    imname = test_imagenames{i};
    I = imread(['../data/',imname]);
    if mod(i,100)==0
        disp([i,t]);
    end
%    disp(imname(1:end-3))
    testFeatures(i,:) = applyHog(I,precision);
end

save('visionHOG.mat','precision','n','N','trainFeatures','testFeatures','train_labels','test_labels');
