function calibrated = calibrate_intensity(measurement, darks, flats, biass, ...
                                          checkerboard_points, board_size)
    D_hsv = cellfun(@rgb2hsv, darks, 'UniformOutput', false);
    B_hsv = cellfun(@rgb2hsv, biass, 'UniformOutput', false);
    F_hsv = cellfun(@rgb2hsv, flats, 'UniformOutput', false);
    M_hsv = rgb2hsv(measurement);
    D_V = cellfun(@(x) x(:, :, 3), darks, 'UniformOutput', false);
    B_V = cellfun(@(x) x(:, :, 3), biass, 'UniformOutput', false);
    F_V = cellfun(@(x) x(:, :, 3), flats, 'UniformOutput', false);
    M_V = M_hsv(:, :, 3);

    dm = mean(cat(3, D_V{:}), 3);
    bm = mean(cat(3, B_V{:}), 3);
    fm = sum(cat(3, F_V{:}), 3);
    normF = fm / (mean(fm(:)));
    normF2 = remove_checkerboard(normF, checkerboard_points, board_size);

    calibrated_v = ((M_V - bm - dm) ./ normF2);
    calibrated_hsv = M_hsv;
    calibrated_hsv(:, :, 3) = calibrated_v;
    calibrated = hsv2rgb(calibrated_hsv);
end
