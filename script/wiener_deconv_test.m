% A = imread('test/1/0.jpg');
% PSF = fspecial('motion', 5, 45);
PSF = fspecial('gaussian', [9 9], 1);

% A_d = imfilter(A, PSF, 'conv', 'circular');
A_d = imread('test/7/34.jpg');
% figure('Name', 'Input image'); imshow(A);
figure('Name', 'Distorted image'); imshow(A_d);

NSR = 0;

[Hw, C] = wiener_deconv(A_d, PSF, NSR);
figure('Name', 'Restored image'); imshow(C);

D = deconvwnr(A_d, PSF, NSR);
figure('Name', 'Restored image with deconvwnr'); imshow(D);

D_f = fft2(D);
D_f_disp = fftshift(log10(1 + abs(D_f)));

fprintf('Range of FFT restored image with deconvwnr is %d to %d\n', min(min(abs(D_f))), max(max(abs(D_f))));
figure('Name', 'FFT of restored image with deconvwnr'); imshow(D_f_disp ./ max(max(D_f_disp)));
