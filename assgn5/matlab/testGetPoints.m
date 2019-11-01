%imgPath = '../data/airport/sun_aflgtvhkyftqgkgx.jpg';
%imgPath = '../data/airport/sun_aerinlrdodkqnypz.jpg';
%imgPath = '../data/airport/sun_ajlsjdjuycxuthrc.jpg';
imgPath = '../data/auditorium/sun_ageaudwlvlioisiq.jpg';

a = 500;

I = imread(imgPath);
imshow(I);
hold;
P = getRandomPoints(I, a);
plot(P(:,1), P(:,2), 'bo');
P = getHarrisPoints(I,a,0.06);
plot(P(:,1), P(:,2), 'ro');
