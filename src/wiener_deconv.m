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

    [M, N] = size(F, 1:2);

    I_in_f = fft2(F, 2*M, 2*N);
    PSF_f = fft2(H, 2*M, 2*N);

    H_w_f = conj(PSF_f) ./ ((abs(PSF_f) .^ 2) + NSR);
    I_out_f = H_w_f .* I_in_f;

    H_w = ifft2(H_w_f);
    I_out_padded = real(ifft2(I_out_f));
    I_out = I_out_padded(1:M, 1:N, :);
end
