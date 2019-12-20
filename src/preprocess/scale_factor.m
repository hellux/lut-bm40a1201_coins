% Calculate k such that distance_mm = k * distance_px
% using a checkerboard with known square widths.
function k = scale_factor(I);
    [checkerboard_points, board_size] = detectCheckerboardPoints(I);

    if size(checkerboard_points, 1) > 0
        h = board_size(1)-2;
        w = board_size(2)-2;

        topleft = checkerboard_points(1, :);
        botleft = checkerboard_points(1+h, :);
        topright = checkerboard_points(end-h, :);
        botright = checkerboard_points(end, :);

        WIDTH_MM = 12.5;
        width_px = mean([norm(topleft-botleft)/h...
                         norm(botleft-botright)/w...
                         norm(botright-topright)/h...
                         norm(topright-topleft)/w
                        ]);
        k = WIDTH_MM / width_px;
    else
        k = 1;
    end
end
