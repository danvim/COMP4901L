load("visionSVM.mat");
load("../data/traintest.mat");
load("idf.mat");
addpath('../matlab');

%% SVM

[~, K] = size(trainFeatures);
[~, testCount] = size(test_labels);
Xtest = zeros(testCount, 100);
for i=1:testCount
    imgName = regexp( test_imagenames(i), "([^.]+)", 'match' );
    testName = imgName{1}{1};
    load("../harrismat/" + testName + ".mat");
    Xtest(i,:) = getImageFeatures(wordMap, 100) .* IDF;
end

Xtrain = trainFeatures;
for i=1:K
    Xtrain(:,i) = Xtrain(:,i) .* IDF(i);
end

svmLinear = svmtrain(train_labels', Xtrain, '-t 0 -c 5500 -q');
[pLabelsLinear, aLinear, ~] = svmpredict(test_labels', Xtest, svmLinear);

%% 1NN
%{
testNames = cell(1, testCount);
for i=1:testCount
    imgName = regexp( test_imagenames(i), "([^.]+)", 'match' );
    testNames{i} = imgName{1}{1};
end
confusions = zeros(8);
% start comparing test images
for t=1:testCount
    testLabel = test_labels(t);
    load("../harrismat/" + testNames{t} + ".mat");
    h = getImageFeatures(wordMap, 100) .* IDF;
    D = getImageDistance(h, Xtrain, "chi2");
    [~, mini] = min(D);
    nnLabel = train_labels(mini);
    confusions(nnLabel, testLabel) = confusions(nnLabel, testLabel) + 1;
end
disp(confusions);
disp("accuracy = " + sum(diag(confusions))/testCount);
%}