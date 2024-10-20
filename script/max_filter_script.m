nama = input('Masukkan nama bmp: ', 's');
if exist([nama, '.bmp'], 'file') == 0
    error('Tidak ada file dengan nama tersebut!');
end

I = imread([nama, '.bmp']);


type = input('Masukkan tipe derau: ', 's');


density = input('Masukkan density noise: ', 's');
density = str2double(density);

if isnan(density) || density < 0 || density > 1
    error('Density tidak valid!');
end


m = input('Masukkan ukuran mask (m): ', 's');
m = str2double(m);

if isnan(m) || floor(m) ~= m
    error('Ukuran mask tidak valid!');
elseif m > size(I, 1)
    error('Ukuran mask terlalu besar!');
else
    m = int32(m);
end


n = input('Masukkan ukuran mask (n): ', 's');
n = str2double(n);

if isnan(n) || floor(n) ~= n
    error('Ukuran mask tidak valid!');
elseif n > size(I, 2)
    error('Ukuran mask terlalu besar!');
else
    n = int32(n);
end


[noisy_I, new_I] = max_filter(I, type, density, m, n);


figure; imshow(I); title('Citra Semula');
figure; imhist(I); title('Histogram Citra Semula');

if (type == "gaussian")
    figure; imshow(noisy_I); title('Citra Derau Gaussian');
    figure; imhist(noisy_I); title('Histogram Citra Derau Gaussian');
elseif (type == "salt&pepper")
    figure; imshow(noisy_I); title('Citra Derau Salt&Pepper');
    figure; imhist(noisy_I); title('Histogram Citra Derau Salt&Pepper');
end

figure; imshow(new_I); title('Citra Hasil MaxFilter');
figure; imhist(new_I); title('Histogram Citra Hasil MaxFilter');