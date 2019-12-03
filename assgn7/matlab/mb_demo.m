%tracker = [1 1 100 100]         % TODO Pick a bounding box in the format [x y w h]
% traker for landing
%tracker = [440    79   118    58];         % TODO Pick a bounding box in the format [x y w h]
tracker = [244   43   69   36];         % TODO Pick a bounding box in the format [x y w h]
%tracker = [415 63 170 95];         % TODO Pick a bounding box in the format [x y w h]
% You can use ginput to get pixel coordinates

% traker for car
tracker = [115   96  189  160];


do_car = 1;

%% Initialize the tracker
figure;

% TODO run the Matthew-Baker alignment in both landing and car sequences
if do_car == 1
    prev_frame = imread('../data/car/frame0020.jpg');
    mov = VideoWriter('../mb_results/car.mp4');
    r = 21:280;
else
    r = 191:308;
    prev_frame = imread('../data/landing/frame0190_crop.jpg');
    mov = VideoWriter('../mb_results/landing.mp4');
end
open(mov);
%subplot(1,2,1)
imshow(prev_frame);
title('drag to create tracker')
tracker = floor(getrect);
x=tracker(1);
y=tracker(2);
w=tracker(3);
h=tracker(4);
template = prev_frame(y:y+h-1, x:x+w-1);
Win = Wp([0 0 0 0 0 0]);

context = initAffineMBTracker(prev_frame, tracker);

%pause

%% Start tracking
new_tracker = tracker

%for i = 191:308
for i = r
    try
        if do_car
            im = imread(sprintf('../data/car/frame%04d.jpg', i));
        else
            im = imread(sprintf('../data/landing/frame%04d_crop.jpg', i));
        end
    catch E
        continue
    end
%    template = prev_frame(y:y+h-1, x:x+w-1);
    try
        Wout = affineMBTracker(im, template, tracker, Win, context);
    catch
        continue
    end

%    new_tracker = ?? % TODO calculate the new bounding rectangle
    xy1 = Wout*[tracker(1)+tracker(3)/2;tracker(2)+tracker(4)/2;1];
%    x1 = xy1
    new_tracker = [xy1(1)/xy1(3)-w/2, xy1(2)/xy1(3)-h/2, w, h];

    clf;
    hold on;
%    s = subplot(1,2,1)
    imshow(im);
    title(sprintf('%i/%i',i,r(end)))
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    F = getframe(gca);
    writeVideo(mov, F.cdata);

    prev_frame = im;
    tracker = new_tracker;
    fprintf("frame %i\n", i);
%    pause;
end

close(mov);
