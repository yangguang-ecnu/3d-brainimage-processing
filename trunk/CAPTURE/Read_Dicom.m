Y = dicomread('../DATA/BRAINIX/SOUS-702/IM-0001-0001.dcm');
imtool(Y,'DisplayRange',[])
min(min(Y))
max(max(Y))


