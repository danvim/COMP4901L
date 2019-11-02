I = loadImage();
method = 'random';
if method == 'random'
    path = 'dictionaryRandom.mat'
else
    path = 'dictionaryHarris.mat'
end;
load(path);
FB = createFilterBank();
getVisualWords(I, FB, dict)
