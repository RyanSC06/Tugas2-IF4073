function [H_w, I_out] = wiener_deconv(I_in, H, K)
    arguments (Input)
        I_in (:,:,:) {mustBeNumeric}
        H (:,:) {mustBeNumeric}
        K double
    end
    arguments (Output)
        H_w (:,:) {mustBeNumeric}
        I_out (:,:,:) {mustBeNumeric}
    end

    H_f = fft2(H);

    H_inv = 1 ./ H_f;
    H_abs = conj(H_f) .* H_f;

    H_w_f = H_inv .* H_abs / (H_abs + K);

    H_w = real(ifft2(H_w_f));
    I_out = convolution(I_in, H_w); % ???? MUST FIX
end

