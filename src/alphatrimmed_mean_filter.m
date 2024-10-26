function [I_d, result] = alphatrimmed_mean_filter(I, type, density, m, n, d)
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
                value_list = zeros(X * Y);
                
                for u = 1 : X
                    for v = 1 : Y
                        u_sample = i + u - 1;
                        v_sample = j + v - 1;

                        value_list(u * Y + v) = I_d(u_sample, v_sample, k);
                    end
                end
                
                value_list = sort(value_list);
                value_list = value_list(((d/2) + 1):(X * Y - (d/2)));

                new_middlevalue = mean(value_list);

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