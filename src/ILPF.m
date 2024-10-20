function [S1, H, S2, result] = ILPF(f, D0)
    [M, N, C] = size(f);
    f = im2double(f);

    % STEP 1: Tentukan parameter padding
    P = 2*M;
    Q = 2*N;

    % STEP 2: Bangkitkan fungsi penapis ILPF (H)
    % Membuat larik u dan v berisi angka 
    % dari 0 sampai P-1, dan 0 sampai Q-1
    u = 0:(P-1);
    v = 0:(Q-1);
    
    % Nilai pada larik u, yang lebih besar dari setengah kali ukuran
    % citra padded, dikurangi dengan P. Yang di larik v dikurangi Q
    idx = find(u > P/2);
    u(idx) = u(idx) - P;
    
    idy = find(v > Q/2);
    v(idy) = v(idy) - Q;
    
    
    % meshgrid: Fungsi ini membuat dua matriks 2D dari vektor u dan v.
        % Matriks U: Setiap kolom adalah salinan dari u; setiap nilai dalam kolom tersebut merepresentasikan koordinat horizontal.
        % Matriks V: Setiap baris adalah salinan dari v; setiap nilai dalam baris tersebut merepresentasikan koordinat vertikal.
    % Hasil: U dan V masing-masing berisi koordinat relatif untuk setiap titik dalam domain frekuensi.
    [V, U] = meshgrid(v, u);

    % Menghitung jarak setiap titik rleatif terhadap pusat
    D = sqrt(U.^2 + V.^2);

    % Membuat penapis yang hanya berisi 1 atau 0 tergantung D dan D0
    H = double(D <= D0);
    % Penapis juga di-shift seperti citra padded
    H = fftshift(H);


    for k = 1 : C
        % STEP 3: Lakukan transformasi Fourier pada f
        % dengan padding sehingga ukuran menjadi P*Q
        F = fftshift(fft2(f(:, :, k), P, Q));
        
        % MEMBUAT SPEKTRUM FOURIER
        % abs digunakan untuk menghitung magnitude
        % log digunakan untuk mencerahkan display
        S1(:, :, k) = log(1+abs(F));
        
        % STEP 4: Kalikan F dengan H
        G = H.*F;
        S2(:, :, k) = log(1+abs(G));
        % Inverse shift citra hasil
        G = ifftshift(G);
            
        % STEP 5: Ambil bagian real dari inverse FFT of G:
        G = real(ifft2(G));

        % STEP 6: Potong padding sehingga ukuran menjadi semula
        result(:, :, k) = G(1:M, 1:N);
    end
end