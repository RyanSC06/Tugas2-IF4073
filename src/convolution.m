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
        for i = 1 : M
            for j = 1 : N
                new_middlevalue = 0;
                
                % Lakukan operasi konvolusi
                for row = 1 : X
                    for col = 1 : Y
                        % Hitung koordinat citra I yang bersesuaian
                        u = i + row - 1 - floor(X/2);
                        v = j + col - 1 - floor(Y/2);

                        % Ambil pixel citra I dengan pendekatan edge clamping
                        u_sample = min(max(u, 1), M);
                        v_sample = min(max(v, 1), N);
                        I_sample = double(I(u_sample, v_sample, k));

                        new_middlevalue = new_middlevalue + I_sample * mask(row, col);
                    end
                end
    
                % Normalisasi hasil konvolusi terhadap jumlah nilai mask
                if (mask_total > 1)
                    new_middlevalue = floor(new_middlevalue / mask_total);
                end
                
                % Clamp nilai konvolusi ke interval 0..255
                new_middlevalue = min(max(new_middlevalue, 0), 255);
    
                result(i, j, k) = new_middlevalue;
            end
        end
    end
    
    result = uint8(result);
end