function imgs = imreads(dirpath)
    paths = dir(strcat(dirpath, '/*'));
    f = @(x) imread(strcat(x.folder, "/", x.name));
    imgs = arrayfun(f, paths, 'UniformOutput', false);
end
