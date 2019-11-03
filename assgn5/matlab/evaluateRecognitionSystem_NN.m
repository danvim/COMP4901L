load("../data/traintest.mat");
[~, trainCount] = size(train_labels);
[~, testCount] = size(test_labels);

sets = ["harris", "random"];
distances = ["euclidean", "chi2"];
confusions = cell(length(sets), length(distances));
[confusions{:,:}] = deal(zeros(8,8));

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

for s=1:length(sets)
    set = sets(s);
    disp(set);
    H = zeros(trainCount, 100);
    
    disp("loading wordmaps");

    for i=1:trainCount
        if mod(i, 100) == 0
            %disp(i + "/" + trainCount);
        end
        load("../" + set + "mat/" + trainNames{i} + ".mat");
        H(i,:) = getImageFeatures(wordMap, 100);
    end
    
    disp("=====1NN=====")
    
    for d=1:length(distances)
        distance = distances(d);
        % start comparing test images
        for t=1:testCount
            testLabel = test_labels(t);
            load("../" + set + "mat/" + testNames{t} + ".mat");
            h = getImageFeatures(wordMap, 100);
            D = getImageDistance(h, H, distance);
            [~, mini] = min(D);
            nnLabel = train_labels(mini);
            confusions{s,d}(nnLabel, testLabel) = confusions{s,d}(nnLabel, testLabel) + 1;
        end
        disp("confusion - " + set + "/" + distance);
        disp(confusions{s,d});
        disp("accuracy = " + sum(diag(confusions{s,d}))/testCount);
    end
end