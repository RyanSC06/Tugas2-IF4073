function [H_w, I_out] = wiener_deconv(I_in, PSF, NSR)
    arguments (Input)
        I_in (:,:,:) {mustBeNumeric}
        PSF (:,:) {mustBeNumeric}
        NSR (1,1) double
    end
    arguments (Output)
        H_w (:,:) {mustBeNumeric}
        I_out (:,:,:) {mustBeNumeric}
    end

    F = im2double(I_in);
    H = im2double(PSF);

    I_in_f = fft2(F);
    PSF_f = fft2(H, size(F, 1), size(F, 2));

    I_in_f_disp = fftshift(log10(1 + abs(I_in_f)));
    PSF_f_disp = fftshift(log10(1 + abs(PSF_f)));

    fprintf('Range of FFT input image is %d to %d\n', min(min(abs(I_in_f))), max(max(abs(I_in_f))));
    figure('Name', 'FFT of input image'); imshow(I_in_f_disp ./ max(max(I_in_f_disp)));
    figure('Name', 'FFT of error function'); imshow(PSF_f_disp ./ max(max(PSF_f_disp)));

    H_w_f = conj(PSF_f) ./ ((abs(PSF_f) .^ 2) + NSR);
    I_out_f = abs(H_w_f .* I_in_f);

    I_out_f_disp = fftshift(log10(1 + abs(I_out_f)));
    fprintf('Range of FFT restored image is %d to %d\n', min(min(abs(I_out_f))), max(max(abs(I_out_f))));
    figure('Name', 'FFT of restored image'); imshow(I_out_f_disp ./ max(max(I_out_f_disp)));

    H_w = ifft2(H_w_f);
    I_out = min(max(real(ifft2(I_out_f)), 0), 1);
end

