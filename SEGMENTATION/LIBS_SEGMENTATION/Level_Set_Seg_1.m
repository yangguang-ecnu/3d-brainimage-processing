function seg = Level_Set_Seg_1(I,init_mask,max_its,E,T,alpha)

%-- ensures image is 2D double matrix
I = image2graydouble(I);

%-- Create a signed distance map (SDF) from mask
phi=bwdist(init_mask)-bwdist(1-init_mask)-.5;

%main loop
for its = 1:max_its
    
    D = E - abs(I - T);
    K = get_curvature(phi);
    F = -alpha*D + (1-alpha)*K;
    
    dxplus=shiftR(phi)-phi;
    dyplus=shiftU(phi)-phi;
    dxminus=phi-shiftL(phi);
    dyminus=phi-shiftD(phi);
    
    gradphimax_x = sqrt(max(dxplus,0).^2+max(-dxminus,0).^2);
    gradphimin_x = sqrt(min(dxplus,0).^2+min(-dxminus,0).^2);
    gradphimax_y = sqrt(max(dyplus,0).^2+max(-dyminus,0).^2);
    gradphimin_y = sqrt(min(dyplus,0).^2+min(-dyminus,0).^2);
    
    gradphimax = sqrt((gradphimax_x.^2)+(gradphimax_y.^2));
    gradphimin = sqrt((gradphimin_x.^2)+(gradphimin_y.^2));
    
    gradphi=(F>0).*(gradphimax) + (F<0).*(gradphimin);
    
    %stability CFL
    dt = .5/max(max(abs(F.*gradphi)));
    
    %evolve the curve
    phi = phi + dt.*(F).*gradphi;
    
    %reinitialise distance funciton every 50 iterations
    if(mod(its,50) == 0)
        phi=bwdist(phi<0)-bwdist(phi>0);
    end
    
    %intermediate output
    if(mod(its,20) == 0)
        showcontour(I,phi,its);
        subplot(2,2,4);  surf(phi); shading flat;
    end
end

%make mask from SDF
seg = phi<=0; %-- Get mask from levelset

%-- whole matrix derivatives
function shift = shiftD(M)
shift = shiftR(M')';

function shift = shiftL(M)
shift = [ M(:,2:size(M,2)) M(:,size(M,2)) ];

function shift = shiftR(M)
shift = [ M(:,1) M(:,1:size(M,2)-1) ];

function shift = shiftU(M)
shift = shiftL(M')';


function curvature=get_curvature(phi)
dx=(shiftR(phi)-shiftL(phi))/2;
dy=(shiftU(phi)-shiftD(phi))/2;
dxplus=shiftR(phi)-phi;
dyplus=shiftU(phi)-phi;
dxminus=phi-shiftL(phi);
dyminus=phi-shiftD(phi);
dxplusy =(shiftU(shiftR(phi))-shiftU(shiftL(phi)))/2;
dyplusx =(shiftR(shiftU(phi))-shiftR(shiftD(phi)))/2;
dxminusy=(shiftD(shiftR(phi))-shiftD(shiftL(phi)))/2;
dyminusx=(shiftL(shiftU(phi))-shiftL(shiftD(phi)))/2;

nplusx = dxplus./sqrt(eps+(dxplus.^2 )+((dyplusx+dy )/2).^2);
nplusy = dyplus./sqrt(eps+(dyplus.^2 )+((dxplusy+dx )/2).^2);
nminusx= dxminus./sqrt(eps+(dxminus.^2)+((dyminusx+dy)/2).^2);
nminusy= dyminus./sqrt(eps+(dyminus.^2)+((dxminusy+dx)/2).^2);

curvature=((nplusx-nminusx)+(nplusy-nminusy)/2);

%-- Displays the image with curve superimposed
function showcontour(I, phi, i)
subplot(2,2,3); title('Evolution'); 
imshow(I,'initialmagnification',200,'displayrange',[0 255]);
hold on;
contour(phi, [0 0], 'g','LineWidth',2);
hold off; title([num2str(i) ' Iterations']); drawnow;


%-- Converts image to one channel (grayscale) double
function img = image2graydouble(img)
[dimy, dimx, c] = size(img);
if(isfloat(img)) % image is a double
    if(c==3)
        img = rgb2gray(uint8(img));
    end
else           % image is a int
    if(c==3)
        img = rgb2gray(img);
    end
    img = double(img);
end