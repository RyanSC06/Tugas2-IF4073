nama = input('Masukkan nama bmp: ', 's');
if exist([nama, '.bmp'], 'file') == 0
    error('Tidak ada file dengan nama tersebut!');
end

nomor = input('Masukkan nomor mask: ', 's');
nomor = str2double(nomor);

if isnan(nomor) || floor(nomor) ~= nomor || nomor < 1 || nomor > 5
    error('Nomor mask tidak valid!');
else
    nomor = int32(nomor);
end


masks = {
    %1
    [[1/16, 2/16, 1/16]; [2/16, 4/16, 2/16]; [1/16, 2/16, 1/16]];

    %2
    [[0, -1, 0]; [-1, 4, -1]; [0, -1, 0]];
    
    %3
    [[1, 1, 2, 2, 2, 1, 1]; [1, 2, 2, 4, 2, 2, 1]; [2, 2, 4, 8, 4, 2, 2]; [2, 4, 8, 16, 8, 4, 2]; 
     [2, 2, 4, 8, 4, 2, 2]; [1, 2, 2, 4, 2, 2, 1]; [1, 1, 2, 2, 2, 1, 1]];
    
    %4
    [[-1, -1, -1]; [-1, 17, -1]; [-1, -1, -1]];

    %5
    [[-1, -1, -1]; [-1, 8, -1]; [-1, -1, -1]];
};



I = imread([nama, '.bmp']);
figure; imshow(I); title('Citra Semula');
figure; imhist(I); title('Histogram Citra Semula');

new_I = convolution(I, masks{nomor});
figure; imshow(new_I); title('Citra Hasil Konvolusi');
figure; imhist(new_I); title('Histogram Citra Hasil Konvolusi');