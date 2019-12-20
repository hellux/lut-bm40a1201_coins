%pkg load image;

addpath('../io');
addpath('../preprocess');
addpath('../classify');

mfs = membership_functions();
coinstrs = {".05", ".1", ".2", ".5", "1", "2"};

Is = imreads('../../img/Teams6-7/');
n = 1;
n = length(Is)
for i = 1:n
    I = Is{i};
    %I = imread('../../img/Measurements/_DSC1774.JPG');
    I = imresize(I, 0.2);
    w = size(I, 1);
    h = size(I, 2);

    k = scale_factor(checkerboard_points, board_size);

    T = graythresh(I)*1.4;

    I_hsv = rgb2hsv(I);
    Iv = I_hsv(:, :, 3);
    I_otsu = ~imbinarize(Iv, T);

    [centers, radii, metric] = imfindcircles(I_otsu, [10 0.2*h],...
                                             'ObjectPolarity', 'bright',...
                                             'Method', 'TwoStage');
    metric_threshold = 0.5;
    centers = centers(metric > metric_threshold, :);
    radii = radii(metric > metric_threshold, :);

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
    features

    viscircles(centers, radii);
    fname = strcat('../../out/circles', int2str(i), '.png');
    saveas(f, fname);

    %figure; imshow(Iv);
    %figure; imshow(I);
    %figure; imshow(I_otsu);
    %figure; imshow(imopen(imclose(I_otsu, ones(6)), ones(3)));
    f = figure('visible', false); imshow(I_otsu)
    fname = strcat('../../out/circles', int2str(i), 'th.png');
    saveas(f, fname);
end
