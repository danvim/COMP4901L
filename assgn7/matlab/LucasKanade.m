function [u,v] = LucasKanade(It, It1, rect)

th = 0.01;
maxIter = 100;


It1 = double(It1);
x = rect(1);
y = rect(2);
w = rect(3);
h = rect(4);

it = double(It(y:y+h, x:x+w));

s = fspecial('sobel');

ix = imfilter(it, s', 'replicate');
iy = imfilter(it, s, 'replicate');

u = 0;
v = 0;

[Y, X] = meshgrid(y:y+h, x:x+w);

for i = 1:maxIter
    it1 = interp2(It1, X+u, Y+v)' - it;
    vel = [ix(:), iy(:)] \ it1(:);
    u = u + vel(1);
    v = v + vel(2);
    if max(abs(vel)) < th
        break;
    end
end