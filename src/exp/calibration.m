addpath('../io');
addpath('../preprocess');

meas = imread('../../img/Measurements/_DSC1772.JPG');
dark = imreads('../../img/Dark/');
flat = imreads('../../img/Flat/');
bias = imreads('../../img/Bias/');

[checkerboard_points, board_size] = detectCheckerboardPoints(meas);
cal = calibrate_intensity(meas, dark, flat, bias, ...
      checkerboard_points, board_size);

imwrite(meas, '../../out/meas.png');
imwrite(cal, '../../out/cal.png');
