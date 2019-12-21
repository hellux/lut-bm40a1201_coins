%pkg load image;

addpath('../io');
addpath('../preprocess');
addpath('../classify');

mfs = membership_functions();
coinstrs = {"5c", "10c", "20c", "50c", "1eur", "2eur"};

Is = imreads('../../img/Measurements/');
n = 1;
n = length(Is);
for i = 1:n
    I = Is{i};
    %I = imread('../../img/Measurements/_DSC1774.JPG');
    I = imresize(I, 0.2);

    [checkerboard_points, board_size] = detectCheckerboardPoints(I);
    k = scale_factor(checkerboard_points, board_size);
    I_hsv = rgb2hsv(I);
    Iv = I_hsv(:, :, 3);

    Iv_covered = remove_checkerboard(Iv, checkerboard_points, board_size);
    [centers, radii] = segment_coins(Iv, Iv_covered);

    nc = size(centers, 1);
    features = zeros(nc, 3);
    f = figure('visible', false); imshow(I)
    for j = 1:nc;
        c = centers(j, :);
        r = radii(j);
        features(j, :) = extract_features(c, r, I_hsv, k);
        coin = classify_coin(features(j, :), mfs);
        text(c(1), c(2), strcat(int2str(j), ':', coinstrs{coin}));
    end
    viscircles(centers, radii);
    fname = strcat('../../out/circles', int2str(i), '.png');
    saveas(f, fname);

    coin_count = size(mfs, 1);
    feature_count = size(mfs, 2);
    f1 = figure();
    ranges = [17 0.1 28; 0 0.01 0.2; -0.3 0.01 0.3];
    for j = 1:nc;
        for l = 1:feature_count
            x = ranges(l, 1):ranges(l, 2):ranges(l, 3);
            subplot(nc, 3, (j-1)*3+l);
            hold on;
            xline(features(j, l));
            hold on;
            title(num2str(features(j, l)));
            for k = 1:coin_count
                f = mfs{k, l};
                plot(x, arrayfun(mfs{k, l}, x));
                hold on;
            end
        end
    end
    fname = strcat('../../out/circles', int2str(i), 'graphs.png');
    saveas(f1, fname);
end
