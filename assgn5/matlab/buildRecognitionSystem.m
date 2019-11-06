load('../data/traintest.mat','train_imagenames', 'train_labels');

method = 'harris';


if method == 'random'
Camel = 'Random';
else
Camel = 'Harris';
end

dictionary = load(['dictionary',Camel,'.mat'],'dict');
dictionary = dictionary.dict;
[K,n3] = size(dictionary);
n = n3/3;
filterBank = createFilterBank();

[~,T] = size(train_imagenames);
trainFeatures = zeros(T,K);
%trainLabels = zeros(T,1);
for i = 1:T
    imname = train_imagenames{i};
    disp(imname(1:end-3))
    load(['../',method,'mat/',imname(1:end-3),'mat'], 'wordMap');
    trainFeatures(i,:) = getImageFeatures(wordMap,K);
%    [~,trainLabels(i)] = max(trainFeatures(i,:));
end
trainLabels = train_labels;
save(['vision',Camel,'.mat'],'dictionary', 'filterBank','trainFeatures','trainLabels');
