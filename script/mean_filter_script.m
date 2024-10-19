nama = input('Masukkan nama bmp: ', 's');
if exist([nama, '.bmp'], 'file') == 0
    error('Tidak ada file dengan nama tersebut!');
end

I = imread([nama, '.bmp']);


n = input('Masukkan ukuran mask (n): ', 's');
n = str2double(n);

if isnan(n) || floor(n) ~= n
    error('Ukuran mask tidak valid!');
elseif n > size(I, 1) || n > size(I, 2)
    error('Ukuran mask terlalu besar!');
else
    n = int32(n);
end


new_I = mean_filter(I, n);


figure; imshow(I); title('Citra Semula');
figure; imhist(I); title('Histogram Citra Semula');
figure; imshow(new_I); title('Citra Hasil Penapis Rerata');
figure; imhist(new_I); title('Histogram Citra Hasil Penapis Rerata');