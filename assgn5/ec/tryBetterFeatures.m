%addpath('../matlab');
%
%load("../data/traintest.mat");
%[~, trainCount] = size(train_labels);
%[~, testCount] = size(test_labels);
%
%[~,T] = size(train_imagenames);
%[~,t] = size(test_imagenames);
%
%precision = 45;
%n = 360/precision;
%N = 3*n;
%
%trainFeatures = zeros(T,N);
%for i = 1:T
%    imname = train_imagenames{i};
%    I = imread(['../data/',imname]);
%%    disp(imname(1:end-3))
%    trainFeatures(i,:) = applyHog(I,precision);
%end
%
%testFeatures = zeros(t,N);
%for i = 1:t
%    imname = test_imagenames{i};
%    I = imread(['../data/',imname]);
%%    disp(imname(1:end-3))
%    testFeatures(i,:) = applyHog(I,precision);
%end

load('visionHOG.mat');

svmLinear = svmtrain(train_labels', trainFeatures, '-t 0 -c 5000 -q');
[pLabelsLinear, aLinear, ~] = svmpredict(test_labels', testFeatures, svmLinear);
