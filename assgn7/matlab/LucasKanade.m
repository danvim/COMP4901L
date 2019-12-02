function [u,v] = LucasKanade(It, It1, rect)

th = 1e-6;
maxIter = 100;

It = double(It);
It1 = double(It1);
x = rect(1);
y = rect(2);
w = rect(3);
h = rect(4);

%[X_, Y_] = meshgrid(1:w+1, 1:h+1);
%it = interp2(It, X_+x, Y_+y);
x_ = round(x);
y_ = round(y);
it = It(y_:y_+h, x_:x_+w);

s = fspecial('sobel');

ix = imfilter(it, s', 'replicate');
iy = imfilter(it, s, 'replicate');

u = 0;
v = 0;

[X, Y] = meshgrid(x:x+w, y:y+h);

for i = 1:maxIter
    it1 = interp2(It1, X+u, Y+v) - it;
    %it1 = It1(y_+round(v):y_+h+round(v), x_+round(u):x_+w+round(u)) - it;
    vel = [ix(:), iy(:)] \ it1(:);
    u = u + vel(1);
    v = v + vel(2);
    if u^2 + v^2 < th
        break;
    end
end