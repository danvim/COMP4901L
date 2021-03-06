load('../harrismat/airport/sun_aerprlffjscovbbc.mat','wordMap');
w1 = wordMap;
load('../harrismat/airport/sun_aesovualhburmfhn.mat','wordMap');
w2 = wordMap;
load('../harrismat/rainforest/sun_aacykkmwtykjfldf.mat','wordMap');
w3 = wordMap;
h1 = getImageFeatures(w1, 100);
h2 = getImageFeatures(w2, 100);
h3 = getImageFeatures(w3, 100);
dc = getImageDistance(h1, [h1;h2;h3], "chi2");
de = getImageDistance(h1, [h1;h2;h3], "euclidean");
disp(dc);
disp(de);