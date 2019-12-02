px = 464;
py = 103;
ww = 50;

tracker = [px-ww, py-ww, ww*2, ww*2];
disp(tracker);
% You can use ginput to get pixel coordinates

%% Initialize the tracker
figure;

prev_frame = im2double(imread('../data/landing/frame0190_crop.jpg'));

mov = VideoWriter('../lk_results/landing.mp4');
open(mov);
%% Start tracking
for i = 190:308
    try
        new_frame = im2double(imread(sprintf('../data/landing/frame0%03d_crop.jpg', i)));
    catch E
        continue
    end
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

