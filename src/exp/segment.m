pkg load image;

addpath('src/io');

%Is = imreads('img/Measurements/');

n = 1;
%n = length(Is)
for i = 1:n
    %I = Is{i};
    I = imread('img/Measurements/_DSC1783.JPG');
    I = imresize(I, 0.2);
    w = size(I, 1);
    h = size(I, 2);

    T = graythresh(I)*1.4;

    I_hsv = rgb2hsv(I);
    Iv = I_hsv(:, :, 3);
    I_otsu = arrayfun(@(x) x < T, Iv);

    [centers, radii, metric] = imfindcircles(I_otsu, [10 0.2*h]);
    metric_threshold = 0.5;
    centers = centers(metric > metric_threshold, :);
    radii = radii(metric > metric_threshold, :);

    figure; imshow(I)
    viscircles(centers, radii);

    for i = 1:1 %length(centers);
        cx = centers(i, 1);
        cy = centers(i, 2);
        r = radii(i);
        hues = zeros(0, 1);
        sats = zeros(0, 1);
        vals = zeros(0, 1);
        for y = 1:h
            for x = 1:w
                if ((x-cx).^2 + (y-cy).^2) <= r.^2;
                    hues(end+1) = I_hsv(y, x, 1);
                    sats(end+1) = I_hsv(y, x, 2);
                    vals(end+1) = I_hsv(y, x, 3);
                end
            end
        end
        size(hues)
        hist(hues);
    end
    %figure; imshow(Iv);
    %figure; imshow(I);
    %figure; imshow(I_otsu);
    figure; imshow(imopen(imclose(I_otsu, ones(6)), ones(3)));
end
pause;
