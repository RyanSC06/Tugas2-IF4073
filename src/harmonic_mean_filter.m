function [I_d, result] = harmonic_mean_filter(I, type, density, m, n)
    if (type == "salt&pepper")
        I_d = imnoise(I, 'salt & pepper', density);
    elseif (type == "gaussian")
        I_d = imnoise(I, 'gaussian', 0, density);
    else
        error("Noise type is not supported!");
    end

    [M, N, C] = size(I_d);
    X = m;
    Y = n;

    % Menyiapkan matriks citra keluaran seukuran I
    result = zeros(M, N, C);
    
    for k = 1 : C
        for i = 1 : M - X + 1
            for j = 1 : N - Y + 1
                new_middlevalue = 0;
                
                for u = i : (i + X-1)
                    for v = j : (j + Y-1)
                        new_middlevalue = new_middlevalue + (1/double(I_d(u, v, k)));
                    end
                end
                
                new_middlevalue = floor(double(X*Y) / double(new_middlevalue));

                if (new_middlevalue < 0)
                    new_middlevalue = 0;
                elseif (new_middlevalue > 255)
                    new_middlevalue = 255;
                end
    
                result((i + floor(X/2)), (j + floor(Y/2)), k) = new_middlevalue;
            end
        end
    end


    for i = 1 : M
        for j = 1 : N
            for k = 1 : C
                if (i <= floor(X/2) || j <= floor(Y/2) || i > M - floor(X/2) || j > N - floor(Y/2))
                    result(i, j, k) = I_d(i, j, k);
                end
            end
        end
    end
    
    result = uint8(result);
end