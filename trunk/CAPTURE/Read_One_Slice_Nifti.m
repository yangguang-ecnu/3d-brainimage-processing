clc;
addpath('LIBS_CAPTURE');        % In this directory load_nii exists;
Nifti = load_nii(...
        '../DATA/NIFTI/DATA_1/rsource_mri.hdr');
Nifti                   %Printing Nifti Object properties.

ImageV=Nifti.img;       %Capturing Volumetric Information
[Height Width Large] = size(ImageV)

F = Capturing_Slice(ImageV,3,100); %Capturing Coronal (type = 1) Image at distance 100;

imshow(F);
imcontrast;