function [bifilterHue] = BilateralFilterHue(Image, w, sigma)
ImgD = double(Image)/255;
ImBF = bfilter2(ImgD,w,sigma);
ImBF(ImBF<0) = 0; ImBF(ImBF>1) = 1;
ImBF = uint8(255*ImBF);

HSV = rgb2hsv(ImBF);
if size(Image, 3) == 1
    bifilterHue = ImBF;
else
    bifilterHue = HSV(:,:,1);
end