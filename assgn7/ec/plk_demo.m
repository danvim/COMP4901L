%px = 552;
%py = 126;
%ww = 10;
%
%tracker = [px-ww, py-ww, ww*2, ww*2];
%disp(tracker);
% You can use ginput to get pixel coordinates

%% Initialize the tracker
figure;

% landing
prev_frame = im2double(imread('../data/landing/frame0190_crop.jpg'));
%tracker = [440    82    52    44];         % TODO Pick a bounding box in the format [x y w h]

% car
%prev_frame = im2double(imread('../data/car/frame0020.jpg'));
%tracker = [188  175   85   34];

imshow(prev_frame);

tracker = floor(getrect);




%mov = VideoWriter('../plk_results/car');
mov = VideoWriter('../plk_results/landing');
open(mov);
%% Start tracking
for i = 190:308
%for i = 20:280
    try
        new_frame = im2double(imread(sprintf('../data/landing/frame0%03d_crop.jpg', i)));
%        new_frame = im2double(imread(sprintf('../data/car/frame0%03d.jpg', i)));
    catch E
        fprintf("err at frame %i ",i)
        if E.identifier == 'MATLAB:imagesci:imread:fileDoesNotExist'
            disp('not found')
        else
            disp(E)
        end
        continue
    end
    [u, v] = LucasKanade_Pyramid(prev_frame, new_frame, tracker);

    clf;
    hold on;
    imshow(new_frame);  
    prev_frame = new_frame;
    tracker(1) = tracker(1) + u;
    tracker(2) = tracker(2) + v;
    rectangle('Position', tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    
    F = getframe(gca);
    writeVideo(mov, F.cdata);

    fprintf('frame %i (%d, %d)\n',i, tracker(1), tracker(2))
end
close(mov);

