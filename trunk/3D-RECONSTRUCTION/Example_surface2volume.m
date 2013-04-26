addpath('LIBS_RECONSTRUCT');
load mri;
D = squeeze(D);
D = padarray(D,[5 5 5],'both');

% Create an isosurface
Ds = smooth3(D);
surface = isosurface(Ds,5);

% Display the surface
figure;
subplot(1,2,1);
hiso = patch('Vertices',surface.vertices,...
    'Faces',surface.faces,...
    'FaceColor',[1,.75,.65],...
    'EdgeColor','none');

view(45,30)
axis tight
daspect([1,1,.4])
lightangle(45,30);
set(gcf,'Renderer','zbuffer'); lighting phong
isonormals(Ds,hiso)
set(hiso,'SpecularColorReflectance',0,'SpecularExponent',50)

% Reconstruct the volume and display it as montage
OV = surface2volume(surface,[],1);
nDims = size(OV);
subplot(1,2,2);
montage(reshape(OV,nDims(1),nDims(2),1,nDims(3)),[0 1]);
