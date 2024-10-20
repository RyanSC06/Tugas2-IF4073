function [I, result] = arithmetic_mean_filter(I, type, density, m, n)
    if (type == "salt&pepper")
        I = imnoise(I, 'salt & pepper', density);
    elseif (type == "gaussian")
        I = imnoise(I, 'gaussian', 0, density);
    else
        error("Noise type is not supported!");
    end

    mask = ones(m, n);
    mask = mask / double(m*n);

    result = convolution(I, mask);
end