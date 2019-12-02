px = 218;
py = 218;
ww = 20;

tracker = [px-ww, py-ww, ww*2, ww*2];
disp(tracker);
% You can use ginput to get pixel coordinates

%% Initialize the tracker
figure;

prev_frame = imread('../data/car/frame0020.jpg');

mov = VideoWriter('../results/car.mp4');
open(mov);
%% Start tracking
for i = 20:280
    new_frame = imread(sprintf('../data/car/frame0%03d.jpg', i));
    [u, v] = LucasKanade(prev_frame, new_frame, tracker);

    clf;
    hold on;
    imshow(new_frame);   
    rectangle('Position', tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    
    F = getframe(gca);
    writeVideo(mov, F.cdata);

    prev_frame = new_frame;
    tracker(1) = tracker(1) + u;
    tracker(2) = tracker(2) + v;
end
close(mov);

