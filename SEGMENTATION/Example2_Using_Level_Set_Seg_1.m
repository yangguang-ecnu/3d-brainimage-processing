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

 
% OBTIENE IMAGEN Y LA CONVIERTE EN 2D
 

x2 = E;%imagen en dos dimensiones
imshow(x2)
 
% UMBRALIZACION
 
result=x2>=128;
figure
imshow(result)
 
% REDUCIR INTENSIDAD DE LA IMAGEN
 
% imagegrayD = double(imagegray) %convierte a double
% imagegrayD=imagegrayD*2 %modifica la intensidad
% imagegray=uint8(imagegrayD) %convierte a entero
% figure
% imshow(imagegray)
 
% FILTRAJE ESPACIAL
 
% image3=double(x2);
% imageR=nlfilter(image3,[3 3],@myfunction);    %Aplica filtro a la imagen                           
% imageR=uint8(imageR);
% figure
% imshow(imageR);
 
% EXTRACCION DE BORDES
 
% ImageR1=edge(x2,'canny'); % deteccion de bordes con el algoritmo de canny
% figure
% imshow(ImageR1);
% ImageR2=edge(x2,'sobel'); % deteccion de bordes con el algoritmo de sobel
% figure
% imshow(ImageR2);
 
%OPERACIONES MORFOLOGICAS
 
% w=eye(3);
% ImageErode=imerode(result,w);
% figure
% imshow(ImageErode);
% ImageDIlate=imdilate(result,w);
% figure
% imshow(ImageDIlate);
 
%OPERACIONES BASADAS EN OBJETOS - CONECTIVIDAD 4 Y 8
 
% y4=bwlabel(result,4);
% figure
% imshow(y4);
% y8=bwlabel(result,8);
% figure
% imshow(y8);
% res=max(max(y4))
% %Se genera la imagen indexada con 154 elementos
% map=[0 0 0;jet(res)]
% figure
% imshow(y4+1,map)
 
% SELECCION DE OBJETOS
 
Z=bwselect(result);
figure
imshow(Z)
 
% EXTRACCION DE CARACTERISTICAS
imageR=bwlabel(Z,8); %agrega labels a las regiones
% figure
% imshow(imageR)
max(max(imageR));
s=imfeature(imageR,'Area');
s(1).Area;
%s(2).Area
s2=imfeature(imageR,'FilledArea');
s2(1).FilledArea;
%Area Image EulerNumberCentroid FilledImage ExtremaBoundingBox FilledArea EquivDiameterMajorAxisLength ConvexHull SolidityMinorAxisLength ConvexImage ExtentOrientation ConvexArea PixelList
 
% centro de la region de interés
BW = Z;
s  = regionprops(BW, 'centroid');
centroids = cat(1, s.Centroid);
figure
imshow(BW)
hold on
plot(centroids(:,1), centroids(:,2), 'b*')
hold off
 
%Si no se especifican medidas retorna, area, centro y el rectangulo mas
%pequeño.
BW = imageR;
s2  = regionprops(BW);
 
