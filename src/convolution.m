function [result] = convolution(I, mask)
    [M, N, C] = size(I);
    [X, Y] = size(mask);
    
    mask_total = 0;
    for i = 1 : X
        for j = 1 : Y
            mask_total = mask_total + mask(i, j);
        end
    end

    % Menyiapkan matriks citra keluaran seukuran I
    result = zeros(M, N, C);
    
    for k = 1 : C
        for i = 1 : M - X + 1
            for j = 1 : N - Y + 1
                new_middlevalue = 0;
                
                row = 0;
                for u = i : (i + X-1)
                    row = row + 1;
                    col = 0;
                    for v = j : (j + Y-1)
                        col = col + 1;
                        new_middlevalue = new_middlevalue + (double(I(u, v, k)) * mask(row, col));
                    end
                end
    
                if (mask_total > 1)
                    new_middlevalue = floor(new_middlevalue / mask_total);
                end
                
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
                    result(i, j, k) = I(i, j, k);
                end
            end
        end
    end
    
    result = uint8(result);
end