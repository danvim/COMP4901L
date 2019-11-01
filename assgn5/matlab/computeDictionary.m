traintest = load('../data/traintest.mat');
imgPaths = traintest.test_imagenames;%(1:5);
alpha = 50;
K = 100;
method = 'random';
if method == 'random'
    path = 'dictionaryRandom.mat'
else
    path = 'dictionaryHarris.mat'
end;

dict = getDictionary(imgPaths, alpha, K, method);

save(path, 'dict');
