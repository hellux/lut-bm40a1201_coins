function mfs = membership_functions()
    mfs = cell(4, 3);
    D = 1; H = 2; S = 3;
    
    % 5 cent coin
    mfs{1, D} = @(x) trapmf(x, [17 20.5 21.25 23]);
    mfs{1, H} = @(x) trapmf(x, [.4 .5 .6 .7]);
    mfs{1, S} = @(x) trapmf(x, [-0.1 0 0 0.1]);

    % 10 cent coin
    mfs{2, D} = @(x) trapmf(x, [17 19.5 19.75 21.5]);
    mfs{2, H} = @(x) trapmf(x, [0.04 0.08 0.10 0.14]);
    mfs{2, S} = @(x) trapmf(x, [-0.1 0 0 0.1]);

    % 20 cent coin
    mfs{3, D} = @(x) trapmf(x, [19 22 22.25 24.5]);
    mfs{3, H} = @(x) trapmf(x, [0.04 0.08 0.10 0.14]);
    mfs{3, S} = @(x) trapmf(x, [-0.1 0 0 0.1]);

    % 50 cent coin
    mfs{4, D} = @(x) trapmf(x, [21 24 24.25 26]);
    mfs{4, H} = @(x) trapmf(x, [0.04 0.08 0.10 0.14]);
    mfs{4, S} = @(x) trapmf(x, [-0.1 0 0 0.1]);

    % 1 euro coin
    mfs{5, D} = @(x) trapmf(x, [20 23 23.25 25]);
    mfs{5, H} = @(x) trapmf(x, [0.04 0.08 0.10 0.14]);
    mfs{5, S} = @(x) zmf(x, [-0.2 -0.05]);

    % 2 euro coin
    mfs{6, D} = @(x) trapmf(x, [22 25.4 25.75 28]);
    mfs{6, H} = @(x) trapmf(x, [0.04 0.08 0.10 0.14]);
    mfs{6, S} = @(x) smf(x, [0.05 0.16]);
end
