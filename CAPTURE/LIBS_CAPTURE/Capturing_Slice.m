function Image_Slice = Capturing_Slice(Volumetric_Information, type, distance)

ImageV=Volumetric_Information;       %Capturing Volumetric Information
[Height Width Large] = size(ImageV)

bad_distance_flag = 0;

if type == 1 %CORONAL IMAGE
    I = zeros(Height , Width);  % I is goint to be our Slice
    I = double(I);
    if distance < Large
        if Height > 1 && Width > 1 && Large > 1
            for i = 1: Height
                for j = 1: Width
                    I(i,j) = double(ImageV(i,j,distance)); %Obtaining Coronal Image
                end
            end
        end
    else
        bad_distance_flag = 1;
    end
end

if type == 2 %FRONTAL IMAGE
    I = zeros(Large , Height);  % I is goint to be our Slice
    I = double(I);
    if distance < Width
        if Height > 1 && Width > 1 && Large > 1
            for i = 1: Height
                for j = 1: Large
                    I(j,i) = double(ImageV(i,distance,j)); %Obtaining Frontal Image
                end
            end
        end
    else
        bad_distance_flag = 1;
    end
    I = flipud(I);
end

if type == 3 %SAGITAL IMAGE
%    I = zeros(Height , Large);  % I is goint to be our Slice
    I = zeros(Large , Width);  % I is goint to be our Slice
    I = double(I);
    if distance < Height
        if Height > 1 && Width > 1 && Large > 1
            for i = 1: Width
                for j = 1: Large
                    I(j,i) = double(ImageV(distance,i,j)); %Obtaining Sagital Image
                end
            end
        end
    else
        bad_distance_flag = 1;
    end
    I = flipud(I);
end

if bad_distance_flag == 1
    disp('Bad Distance');
    Image_Slice = zeros(100,100);
else
    Image_Slice = I;
end


return;