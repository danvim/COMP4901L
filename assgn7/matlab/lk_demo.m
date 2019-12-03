px = 552;
py = 126;
ww = 10;

%tracker = [px-ww, py-ww, ww*2, ww*2];
tracker = [180 180 36 36];
%tracker = [552 126 20 20];
disp(tracker);
% You can use ginput to get pixel coordinates

%% Initialize the tracker
figure;

prev_frame = im2double(imread('../data/car/frame0020.jpg'));

mov = VideoWriter('../lk_results/car');
open(mov);
%% Start tracking
for i = 20:280
    try
        new_frame = im2double(imread(sprintf('../data/car/frame0%03d.jpg', i)));
    catch E
        continue
    end
    [u, v] = LucasKanade(prev_frame, new_frame, tracker);

    prev_frame = new_frame;
    tracker(1) = tracker(1) + u;
    tracker(2) = tracker(2) + v;
    
    clf;
    hold on;
    imshow(new_frame);   
    rectangle('Position', tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    
    F = getframe(gca);
    writeVideo(mov, F.cdata);
end
close(mov);

