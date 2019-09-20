function [lines] = myHoughLineSegments(lineRho, lineTheta, Im)
lines = [];
%% run
% assigns the size of the local window. windows slides along the line and
% draw color if non-flat
window = 3;
% defining what non-float means
threshold = 2;
fill_gap = 4;
min_length = 10;

[h, w] = size(Im);

pad_size = (window - 1) / 2;
padded = padarray(Im, [pad_size, pad_size], 'replicate', 'both');

no = [-1, -1];
begin = no;
last = no;
is_began = false;
saw_empty = 0; % start counting if: saw empty and began
saw_edges = 0;

for i = 1:numel(lineRho)
    r = lineRho(i);
    t = lineTheta(i);
    % from \rho = x cos \theta + y sin \theta
    % y = (\rho - x cos \theta) / sin \theta
    % y = \rho/sin\theta - x * cot\theta
    xs = 1:w;
    ys = floor(r / sin(t) - xs / tan(t));
    for j = 1:numel(ys)
        y = ys(j);
        x = xs(j);
        if y < 1 || y > h || isnan(y)
            continue
        end
        local = padded(y:y+pad_size*2, x:x+pad_size*2);
        is_filled = sum(local,'all') > threshold;
        if ~is_filled && ~is_began
            % skip
        elseif ~is_filled && is_began
            if saw_empty < fill_gap
                saw_empty = saw_empty + 1;
            else
                % line ended. check if min distance attained
                %dist = sqrt((last(1)-begin(1))^2 + (last(2)-begin(2))^2);
                %if (dist >= min_length)
                if (saw_edges >= min_length)
                    ei = numel(lines) + 1;
                    lines(ei).point1 = begin;
                    lines(ei).point2 = last;
                    lines(ei).theta = t;
                    lines(ei).rho = r;
                end
                is_began = false;
                saw_edges = 0;
            end
        elseif is_filled && ~is_began
            saw_empty = 0;
            is_began = true;
            begin = [x, y];
            last = [x, y];
            saw_edges = saw_edges + 1;
        else % is_filled && is_began
            saw_empty = 0;
            last = [x, y];
            saw_edges = saw_edges + 1;
        end
    end
    if (is_began)
        %dist = sqrt((last(1)-begin(1))^2 + (last(2)-begin(2))^2);
        %if (dist >= min_length)
        if (saw_edges >= min_length)
            ei = numel(lines) + 1;
            lines(ei).point1 = begin;
            lines(ei).point2 = last;
            lines(ei).theta = t;
            lines(ei).rho = r;
        end
        is_began = false;
    end
    begin = no;
    last = no;
    saw_empty = 0; % start counting if: saw empty and began
end