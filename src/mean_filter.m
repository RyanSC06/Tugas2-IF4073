function [result] = mean_filter(I, n)
    mask = ones(n, n);
    mask = mask / double(n*n);

    result = convolution(I, mask);
end