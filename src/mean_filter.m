function [result] = mean_filter(I, n)
    mask = ones(n, n);
    mask = mask / double(n*n);

    mask = mask ./ sum(mask, 'all');
    result = convolution(I, mask);
end