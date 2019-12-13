load('../data/bunny.mat');
[h,w,~] = size(N);
X = 1:w;
Y = 1:h;
quiver(X,Y,N(Y,X,1),N(Y,X,2));
set(gca, 'YDir','reverse');

figure

subplot(2,2,1);
imshow(N(:,:,3))
title('0deg');

subplot(2,2,2);
L = [0,sqrt(2)/2,sqrt(2)/2];
imshow(N(:,:,1).*L(1)+N(:,:,2).*L(2)+N(:,:,3).*L(3));
title('45deg top');

subplot(2,2,3);
L = [sqrt(2)/2,0,sqrt(2)/2];
imshow(N(:,:,1).*L(1)+N(:,:,2).*L(2)+N(:,:,3).*L(3));
title('45deg right');

subplot(2,2,4);
L = [sin(degtorad(75)),0,cos(degtorad(75))];
imshow(N(:,:,1).*L(1)+N(:,:,2).*L(2)+N(:,:,3).*L(3));
title('75deg right');
drawnow
