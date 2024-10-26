A = imread('test/7/32.jpg');
PSF = fspecial('motion', 5, 45);

A_d = imfilter(A, PSF, 'conv', 'circular');
figure('Name', 'Input image'); imshow(A);
figure('Name', 'Distorted image'); imshow(A_d);

[Hw, C] = wiener_deconv(A_d, PSF, 0.01);
figure('Name', 'Restored image'); imshow(C);

D = deconvwnr(A_d, PSF, 0.01);
figure('Name', 'Restored image with deconvwnr'); imshow(D);

D_f = fft2(D);
D_f_disp = fftshift(log10(1 + abs(D_f)));

fprintf('Range of FFT restored image with deconvwnr is %d to %d\n', min(min(abs(D_f))), max(max(abs(D_f))));
figure('Name', 'FFT of restored image with deconvwnr'); imshow(D_f_disp ./ max(max(D_f_disp)));
