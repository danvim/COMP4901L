function [u,v] = LucasKanade_Pyramid(IT, IT1, rect)

th = 1e-6;
maxIter = 100;
pyramidLevels = 3;

IT = double(IT);
IT1 = double(IT1);

% Build pyrymids
Its = pyramid(IT, pyramidLevels);
It1s = pyramid(IT1, pyramidLevels);

s = fspecial('sobel');

u = 0;
v = 0;

w = rect(3);
h = rect(4);
midx = rect(1) + w/2;
midy = rect(2) + h/2;

for level = pyramidLevels:-1:1
    scale = 2^(level - 1);
    x = midx / scale - w/2;
    y = midy / scale - h/2;
    
    It = Its{level};
    It1 = It1s{level};
    
    x_ = round(x);
    y_ = round(y);
    it = It(y_:y_+h, x_:x_+w);

    ix = imfilter(it, s', 'replicate');
    iy = imfilter(it, s, 'replicate');
    
    [X, Y] = meshgrid(x:x+w, y:y+h);
    
    u = u * 2;
    v = v * 2;
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
end

end

function O = pyramid(I, level)
O = cell(1, level);
O{1} = I;
for i=2:level
    O{i} = impyramid(O{i-1}, 'reduce');
end
end
