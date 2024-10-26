function [result] = gaussian_filter(I, n, sigma)
    gaussian_mask = zeros(n, n);

    for i = 1 : n
        for j = 1 : n
            x = i - (n+1)/2; % Koordinat x relatif
            y = j - (n+1)/2; % Koordinat y relatif
            gaussian_mask(i, j) = exp(double(-(x^2 + y^2) / (2 * sigma^2))) / double(2 * pi * sigma^2);
        end
    end

    gaussian_mask = gaussian_mask ./ sum(gaussian_mask, 'all');
    result = convolution(I, gaussian_mask);
end