
I1 = imread('b1_c2.tif');
I2 = imread('b3_c2.tif');


%% Fourier transform 
figure; 

subplot(321); imshow(I1, []); axis on; title('I1');
subplot(322); imshow(I2, []); axis on; title('I2');

I1_fourier = fft2(I1);
I2_fourier = fft2(I2);
subplot(323); imagesc(log(abs(fftshift(I1_fourier))));
title('I1 Fourier Transform, magnitude');
subplot(324); imagesc(log(abs(fftshift(I2_fourier))));
title('I2 Fourier Transform, magnitude');

subplot(3,2,5:6);
imagesc(ifft2(I1_fourier .* conj(I2_fourier))); axis image
title('phase correlation')

%% imregcorr
clf;

Ax = [];

ax = subplot(221); 
Ax = [Ax, ax];
imshowpair(I1, I2);
axis on
title('original');

tic
tform = imregcorr(I1, I2);
tform.T

I2reg = padimg(I2, -round(tform.T(3,1)), -round(tform.T(3,2)), 'NW');
toc

ax = subplot(222); 
Ax = [Ax, ax];
imshowpair(I1, I2reg);
axis on
title('imregcorr');

%% DFT with pixel resolution
tic 
[tform, Greg] = dftregistration(fft2(I1), fft2(I2), 1);
tform

I2reg = padimg(I2, round(tform(4)), round(tform(3)), 'NW');
toc

ax = subplot(223); 
Ax = [Ax, ax];
imshowpair(I1, I2reg);
axis on
title('dftregistration, no upscaling');

% inverse FFT
tic
I2regIFFT = ifft2(Greg);
I2regIFFT = uint16(real(I2regIFFT));
toc

%% DFT registration with 0.05 subpixel resolution
tic 
[tform, Greg] = dftregistration(fft2(I1), fft2(I2), 20);
tform

I2reg = padimg(I2, -round(tform(4)), -round(tform(3)), 'NW');
toc

% inverse FFT
tic
I2regIFFT = ifft2(Greg);
I2regIFFT = uint16(real(I2regIFFT));
toc

ax = subplot(224); 
Ax = [Ax, ax];
imshowpair(I1, I2regIFFT);
axis on
title('dftregistration, 20x upscaling');
 
%%
linkaxes(Ax, 'xy');



