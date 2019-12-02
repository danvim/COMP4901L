%tracker = [1 1 100 100]         % TODO Pick a bounding box in the format [x y w h]
tracker = [435 83 130 55];         % TODO Pick a bounding box in the format [x y w h]
%tracker = [415 63 170 95];         % TODO Pick a bounding box in the format [x y w h]
% You can use ginput to get pixel coordinates

tracker = [212.0000  200.0000   20.0000   23.0000];

%% Initialize the tracker
figure;

% TODO run the Matthew-Baker alignment in both landing and car sequences
%prev_frame = imread('../data/landing/frame0190_crop.jpg');
prev_frame = imread('../data/car/frame0020.jpg');
imshow(prev_frame);
tracker = getrect;
x=tracker(1);
y=tracker(2);
w=tracker(3);
h=tracker(4);
template = prev_frame(y:y+h-1, x:x+w-1);
Win = Wp([0 0 0 0 0 0]);

context = initAffineMBTracker(prev_frame, tracker);

%% Start tracking
new_tracker = tracker
%for i = 191:308
for i = 21:280
    try
%    im = imread(sprintf('../data/landing/frame%04d_crop.jpg', i));
    im = imread(sprintf('../data/car/frame%04d.jpg', i));
    catch E
    continue
    end
%    template = prev_frame(y:y+h-1, x:x+w-1);
    Wout = affineMBTracker(im, template, tracker, Win, context);

%    new_tracker = ?? % TODO calculate the new bounding rectangle
    xy1 = Wout*[x;y;1];
%    xy2 = Wout*[x+w-1;y+h-1;1];
%    x1 = xy1
    new_tracker = [xy1(1), xy1(2), w, h];

    clf;
    hold on;
    imshow(im);   
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;

    prev_frame = im;
    tracker = new_tracker;
    fprintf("frame %i\n", i);
%    pause;
end

