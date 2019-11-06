paths = [
    "airport/sun_aerinlrdodkqnypz.jpg",
    "airport/sun_agfgtuuejaamawrv.jpg",
    "airport/sun_afijvcdfbowiakrd.jpg",
    "campus/sun_abpxvcuxhqldcvln.jpg",
    "campus/sun_abslhphpiejdjmpz.jpg",
    "campus/sun_abwbqwhaqxskvyat.jpg"
]

random = load('dictionaryRandom.mat');
harris = load('dictionaryHarris.mat');
FB = createFilterBank();


for i = 1:6
    path = paths(i);
    disp(['../data/',path]);
    I = imread(join(['../data/',path],''));
    words = getVisualWords(I, FB, random.dict);
    save(join(['../saved_mat/random/', path,'.mat'],''), 'words');
    IwordsRandom = label2rgb(words);

    words = getVisualWords(I, FB, harris.dict);
    save(join(['../saved_mat/harris/', path,'.mat'],''), 'words');
    IwordsHarris = label2rgb(words);
    figure;
    III = [I,IwordsRandom, IwordsHarris];
    imshow(III);
    imwrite(III,join(['../saved_mat/', path],''));
end
