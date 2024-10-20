nama = input('Masukkan nama bmp: ', 's');
if exist([nama, '.bmp'], 'file') == 0
    error('Tidak ada file dengan nama tersebut!');
end

f = imread([nama, '.bmp']);


D0 = input('Masukkan cut-off frequency (D0): ', 's');
D0 = str2double(D0);

if isnan(D0)
    error('D0 tidak valid!');
elseif D0 > ((size(f, 1)/2)^2 + (size(f, 2)/2)^2) ^ (1/2)
    error('D0 terlalu besar!');
end


[S1, H, S2, result] = ILPF(f, D0);


figure; imshow(f); title('Citra Semula');
figure; imshow(S1, []); title('Spektrum Fourier Citra Semula (Padded)');

figure; imshow(H); title('Penapis ILPF (Ideal Low Pass Filter)');
figure, mesh(H);

figure; imshow(S2, []); title('Spektrum Fourier Citra Hasil (Padded)');
figure; imshow(result); title('Citra Hasil ILPF (Not Padded)');