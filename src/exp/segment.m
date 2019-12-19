%pkg load image;

addpath('../io');
addpath('../calib');

%Is = imreads('../../img/Teams6-7/');
n = 1;
%n = length(Is)
for i = 1:n
    %I = Is{i};
    I = imread('../../img/Measurements/_DSC1774.JPG');
    I = imresize(I, 0.2);
    w = size(I, 1);
    h = size(I, 2);

    [checkerboard_points, board_size] = detectCheckerboardPoints(I);
    k = scale_factor(checkerboard_points, board_size);

    T = graythresh(I)*1.4;

    I_hsv = rgb2hsv(I);
    Iv = I_hsv(:, :, 3);
    I_otsu = arrayfun(@(x) x < T, Iv);

    [centers, radii, metric] = imfindcircles(I_otsu, [10 0.2*h]);
    metric_threshold = 0.5;
    centers = centers(metric > metric_threshold, :);
    radii = radii(metric > metric_threshold, :);

    f = figure('visible', false); imshow(I)
    for j = 1:length(centers);
        cx = centers(j, 1);
        cy = centers(j, 2);
        r = radii(j);

        text(cx, cy, num2str(round(2*k*r, 2)));
        %hues = zeros(0, 1);
        %sats = zeros(0, 1);
        %vals = zeros(0, 1);
        %for y = 1:h
        %    for x = 1:w
        %        if ((x-cx).^2 + (y-cy).^2) <= r.^2;
        %            hues(end+1) = I_hsv(y, x, 1);
        %            sats(end+1) = I_hsv(y, x, 2);
        %            vals(end+1) = I_hsv(y, x, 3);
        %        end
        %    end
        %end
        %hist(hues);
    end

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
