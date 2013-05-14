addpath('LIBS_SEGMENTATION');        % In this directory regiongrowing exists;
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
%F = dicomread('../DATA/DICOM_SAMPLES/SOUS-702/IM-0001-0022.dcm');
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


%%%%%%%%
%LOADING FROM IMAGE
% I = im2double(imread('../IMAGES/medtest.png'));
% x=198; y=359;
%LOADING FROM VOLUMETRIC IMAGE
I = im2double(E);
[x y] = size(I);
x = 0.5*x;
y = 0.5*y;
%%%%%%%%


J = regiongrowing(I,x,y,0.2); 
figure(1);
imshow(J);
figure(2);
imshow(I);
figure(3);
imshow(I+J);