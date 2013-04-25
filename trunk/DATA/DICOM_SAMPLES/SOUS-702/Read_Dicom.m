%info = dicominfo('IM-0001-0022.dcm');
Y = dicomread('IM-0001-0022.dcm');
imtool(Y,'DisplayRange',[])
%figure, imshow(Y);
%imcontrast;
min(min(Y))
max(max(Y))


