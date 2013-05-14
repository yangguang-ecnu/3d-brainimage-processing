addpath('LIBS_SEGMENTATION');
GI=imread('../IMAGES/lena1.png'); 
I = G(:,:,1);
pad=3; 
MAXVAL=255; 
[Ncut] = graphcuts(I,pad,MAXVAL) 
% function [Ncut] = graphcuts(I) 
% Input: I image 
% pad: spatial connectivity; eg. 3 
% MAXVAL: maximum image value 
% Output: Ncut: Binary map 0 or 1 corresponding to image segmentation