function coins = estim_coins(measurement, dark, flat, bias)
    mfs = membership_functions();
    I = imresize(measurement, 0.2);

    [checkerboard_points, board_size] = detectCheckerboardPoints(I);
    k = scale_factor(checkerboard_points, board_size);
    I = calibrate_intensity(I, ...
        {zeros(size(I))}, {ones(size(I))}, {zeros(size(I))}, ...
        checkerboard_points, board_size);
    [centers, radii] = segment_coins(I, checkerboard_points, board_size);

    coins = zeros(1, 6);
    n = size(centers, 1);
    for j = 1:n;
        features = extract_features(centers(j, :), radii(j), I, k);
        coin = classify_coin(features, mfs);
        if coin > 0
            coins(coin) = coins(coin) + 1;
        end
    end
end
