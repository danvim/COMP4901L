load("visionSVM.mat");
load("../data/traintest.mat");
addpath('../matlab');

[~, testCount] = size(test_labels);
Xtest = zeros(testCount, 100);
for i=1:testCount
    imgName = regexp( test_imagenames(i), "([^.]+)", 'match' );
    testName = imgName{1}{1};
    load("../harrismat/" + testName + ".mat");
    Xtest(i,:) = getImageFeatures(wordMap, 100);
end

svmLinear = svmtrain(train_labels', trainFeatures, '-t 0 -c 10000 -q');
[pLabelsLinear, aLinear, ~] = svmpredict(test_labels', Xtest, svmLinear);

svmRadial = svmtrain(train_labels', trainFeatures, '-t 2 -g 0.12 -c 10000 -q');
[pLabelsRadial, aRadial, ~] = svmpredict(test_labels', Xtest, svmRadial);