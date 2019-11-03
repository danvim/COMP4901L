load("../data/traintest.mat");
[~, trainCount] = size(train_labels);
[~, testCount] = size(test_labels);
K = 1:40;

confusions = cell(1, length(K));
[confusions{:,:}] = deal(zeros(8,8));
A = zeros(1, length(K));

trainNames = cell(1, trainCount);
for i=1:trainCount
    imgName = regexp( train_imagenames(i), "([^.]+)", 'match' );
    trainNames{i} = imgName{1}{1};
end
testNames = cell(1, testCount);
for i=1:testCount
    imgName = regexp( test_imagenames(i), "([^.]+)", 'match' );
    testNames{i} = imgName{1}{1};
end

set = "harris";
distance = "chi2";
H = zeros(trainCount, 100);

disp("loading wordmaps");

for i=1:trainCount
    if mod(i, 100) == 0
        %disp(i + "/" + trainCount);
    end
    load("../" + set + "mat/" + trainNames{i} + ".mat");
    H(i,:) = getImageFeatures(wordMap, 100);
end

for k=K
    disp("=====" + k + "NN=====")

    % start comparing test images
    for t=1:testCount
        testLabel = test_labels(t);
        load("../" + set + "mat/" + testNames{t} + ".mat");
        h = getImageFeatures(wordMap, 100);
        D = getImageDistance(h, H, distance);
        [~, mini] = mink(D, k);
        nnLabels = train_labels(mini);
        nnLabel = mode(nnLabels);
        confusions{k}(nnLabel, testLabel) = confusions{k}(nnLabel, testLabel) + 1;
    end
    A(k) = sum(diag(confusions{k}))/testCount;
end

figure
plot(K, A)
title('Accuracy by k')
xlabel('k')
ylabel('accuracy')

[bestA, maxi] = max(A);
disp("best k = " + maxi);
disp("best confusion");
disp(confusions{maxi});
disp("best accuracy = " + bestA);