function [I_d, result] = arithmetic_mean_filter(I, type, density, m, n)
    if (type == "salt&pepper")
        I_d = imnoise(I, 'salt & pepper', density);
    elseif (type == "gaussian")
        I_d = imnoise(I, 'gaussian', 0, density);
    else
        error("Noise type is not supported!");
    end

    mask = ones(m, n);
    mask = mask / double(m*n);

    mask = mask ./ sum(mask, 'all');
    result = convolution(I_d, mask);
end