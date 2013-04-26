addpath('LIBS_FEATURES');
% Load image
  G=imread('../IMAGES/bigbrain.bmp');
  I = G(:,:,1);
% Set this option to true if you want to see more information
  Options.verbose=false; 
% Get the Key Points
  Ipts=OpenSurf(I,Options);
% Draw points on the image
  PaintSURF(I, Ipts);