clc;
addpath('LIBS_CAPTURE');        % In this directory load_nii exists;
Nifti = load_nii(...
        '../DATA/NIFTI/DATA_1/rsource_mri.hdr');
Nifti                   %Printing Nifti Object properties.

ImageV=Nifti.img;       %Capturing Volumetric Information
[Height Width Large] = size(ImageV)

I = zeros(Height , Width);  % I is goint to be our Slice
I = double(I);
if Height > 1 && Width > 1 && Large > 1
   for i = 1: Height
       for j = 1: Width
           I(i,j) = double(ImageV(i,j,round(Large/3))); %Obtaining Coronal Image
       end
   end
end

imshow(I);
imcontrast;