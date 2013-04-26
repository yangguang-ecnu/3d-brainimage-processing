%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
close all;
addpath('../CAPTURE/LIBS_CAPTURE');        % In this directory load_nii exists;
Nifti = load_nii(...
        '../DATA/NIFTI/DATA_1/rsource_mri.hdr');
Nifti                   %Printing Nifti Object properties.

ImageV=Nifti.img;       %Capturing Volumetric Information
[Height Width Large] = size(ImageV)

F = Capturing_Slice(ImageV,1,100); %Capturing Coronal (type = 1) Image at distance 100;
Minimo = min(min(F));
Maximo = max(max(F));
I = F;
[rows cols] = size(F);
%%IMAGE STRETCHING
for i=1:rows
    for j=1:cols
        I(i,j) = 255*((F(i,j) - Minimo)/(Maximo - Minimo));
    end
end
E = uint8(I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('LIBS_SEGMENTATION');
%I = imread('../IMAGES/bigbrain.bmp');               %-- load the image
I = E;                                               %-- load Slice from NIFTI image
m = zeros(size(I,1),size(I,2));          %-- create initial mask
I = imresize(I,0.6);
m = imresize(m,0.6);

subplot(2,2,1); imshow(I); title('Input Image');
subplot(2,2,2);
imshow(m); title('Initial Mask');
[x,y]=getline('closed');
m=poly2mask(x,y,size(I,1),size(I,2));
hold on; imshow(m); hold off;


seg = Level_Set_Seg_1(I, m, 100, 35, 170, 0.02); %-- Run segmentation
subplot(2,2,1); imshow(seg); title('Final Mask of phi<=0');