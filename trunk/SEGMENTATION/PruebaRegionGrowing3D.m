clc;
close all;

% load mri
% poly = regionGrowing3D(squeeze(D), [66,55,13], 60, Inf, [], true, false);
% plot3(poly(:,1), poly(:,2), poly(:,3), 'x', 'LineWidth', 2)

addpath('../CAPTURE/LIBS_CAPTURE');  
%addpath('LIBS_SEGMENTATION');

Nifti = load_nii(...
        '../DATA/NIFTI/DATA_1/Tumor_Niftti_sT2_401_2.hdr');
Nifti                   %Printing Nifti Object properties.

ImageV=Nifti.img;       %Capturing Volumetric Information
[Height Width Large] = size(ImageV)

D = ImageV;

%[poly, J] = regionGrowing3D(D, [105,147,113], 10, Inf, [], true, false); %xime.hdr
%[poly, J] = regionGrowing3D(squeeze(D), [186,260,209], 10, Inf, [], true, true); % Tumor_Niftti_sT2_301_2.hdr
[poly, J] = regionGrowing3D(squeeze(D), [109,147,109], 20, Inf, [], true, true); % Tumor_Niftti_sT2_401_2.hdr
plot3(poly(:,1), poly(:,2), poly(:,3), 'x', 'LineWidth', 2)
%plot(poly, 'x', 'LineWidth', 2)

F = Capturing_Slice(J,1,109); %Capturing Coronal (type = 1) Image at distance 100;

figure
imshow(F);
%imcontrast;

view_nii(Nifti);

Nifti.img = J;
view_nii(Nifti);




