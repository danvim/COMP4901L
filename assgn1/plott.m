function plott
    function p = p(x,y)
        t = 0:0.01:2*pi;
        r = x*cos(t) + y*sin(t);
        plot(t,r);
        p = 0;
    end
    hold on;
    p(10,10);
    p(20,20);
    p(30,30);
    hold off;
end
