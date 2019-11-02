paths = [
    "../data/airport/sun_aerinlrdodkqnypz.jpg",
    "../data/airport/sun_agfgtuuejaamawrv.jpg",
    "../data/airport/sun_afijvcdfbowiakrd.jpg",
    "../data/campus/sun_abpxvcuxhqldcvln.jpg",
    "../data/campus/sun_abslhphpiejdjmpz.jpg",
    "../data/campus/sun_abwbqwhaqxskvyat.jpg"
]

random = load('dictionaryRandom.mat');
harris = load('dictionaryHarris.mat');
FB = createFilterBank();


for i = 1:6
    path = paths(i);
    I = imread(path);
    words = getVisualWords(I, FB, random.dict);
    IwordsRandom = label2rgb(words);

    words = getVisualWords(I, FB, harris.dict);
    IwordsHarris = label2rgb(words);
    figure;
    imshow([I,IwordsRandom, IwordsHarris]);
end
