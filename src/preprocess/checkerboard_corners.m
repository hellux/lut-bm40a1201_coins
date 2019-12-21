function [topleft, botleft, botright, topright] = ...
        checkerboard_corners(checkerboard_points, board_size);
    h = board_size(1)-2;
    w = board_size(2)-2;

    toplefti = checkerboard_points(1, :);
    botlefti = checkerboard_points(1+h, :);
    botrighti = checkerboard_points(end, :);
    toprighti = checkerboard_points(end-h, :);

    topleft = toplefti + (toplefti-toprighti)/w + (toplefti-botlefti)/h;
    botleft = botlefti + (botlefti-botrighti)/w + (botlefti-toplefti)/h;
    botright = botrighti + (botrighti-botlefti)/w + (botrighti-toprighti)/h;
    topright = toprighti + (toprighti-toplefti)/w + (toprighti-botrighti)/h;
end
