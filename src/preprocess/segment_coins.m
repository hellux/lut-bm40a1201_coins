function [centers, radii] = segment_coins(Iv, Iv_covered)
    T = graythresh(Iv_covered);

    I_otsu = ~imbinarize(Iv, T);
    I_otsu = imopen(imclose(I_otsu, ones(5)), ones(3));

    [centers, radii, metric] = imfindcircles(I_otsu, [10 size(Iv, 1)],...
                                             'ObjectPolarity', 'bright');
    METRIC_THRESHOLD = 0.2;
    centers = centers(metric > METRIC_THRESHOLD, :);
    radii = radii(metric > METRIC_THRESHOLD, :);
end
