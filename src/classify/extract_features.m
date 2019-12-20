% Extract the feature of the coin at the given position c and radius r in HSV
% image I_hsv.
% Image is scaled such that 1 pixel represents k mm.
% return: row vector F containing values for features
function F = extract_features(c, r, I_hsv, k)
    h = size(I_hsv, 1);
    w = size(I_hsv, 2);

    hues = zeros(0, 1);
    sats_inner = zeros(0, 1);
    sats_outer = zeros(0, 1);
    for y = 1:h
        for x = 1:w
            d2 = (x-c(1))^2 + (y-c(2))^2;
            if d2 <= r^2
                hues(end+1) = I_hsv(y, x, 1);
                if d2 <= (0.75*r)^2
                    sats_inner(end+1) = I_hsv(y, x, 2);
                else
                    sats_outer(end+1) = I_hsv(y, x, 2);
                end
            end
        end
    end

    diameter = 2*k*r;
    hue = mean(hues);
    sat_diff = mean(sats_inner) - mean(sats_outer);

    F = [diameter hue sat_diff];
end
