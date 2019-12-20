function coin = classify_coin(features, mfs)
    coin_count = size(mfs, 1);
    feature_count = size(mfs, 2);
    memberships = zeros(1, coin_count);
    for i = 1:coin_count
        ms = zeros(1, feature_count);
        for j = 1:feature_count
            f = mfs{i, j};
            ms(1, j) = f(features(j));
        end
        memberships(i) = min(ms);
    end
    [~, coin] = max(memberships);
end
