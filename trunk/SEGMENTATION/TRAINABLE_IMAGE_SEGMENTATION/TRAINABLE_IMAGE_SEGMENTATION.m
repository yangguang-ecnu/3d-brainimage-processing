function varargout = TRAINABLE_IMAGE_SEGMENTATION(varargin)
% TRAINABLE_IMAGE_SEGMENTATION MATLAB code for TRAINABLE_IMAGE_SEGMENTATION.fig
%      TRAINABLE_IMAGE_SEGMENTATION, by itself, creates a new TRAINABLE_IMAGE_SEGMENTATION or raises the existing
%      singleton*.
%
%      H = TRAINABLE_IMAGE_SEGMENTATION returns the handle to a new TRAINABLE_IMAGE_SEGMENTATION or the handle to
%      the existing singleton*.
%
%      TRAINABLE_IMAGE_SEGMENTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAINABLE_IMAGE_SEGMENTATION.M with the given input arguments.
%
%      TRAINABLE_IMAGE_SEGMENTATION('Property','Value',...) creates a new TRAINABLE_IMAGE_SEGMENTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TRAINABLE_IMAGE_SEGMENTATION_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TRAINABLE_IMAGE_SEGMENTATION_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TRAINABLE_IMAGE_SEGMENTATION

% Last Modified by GUIDE v2.5 09-Jan-2014 00:50:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TRAINABLE_IMAGE_SEGMENTATION_OpeningFcn, ...
                   'gui_OutputFcn',  @TRAINABLE_IMAGE_SEGMENTATION_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before TRAINABLE_IMAGE_SEGMENTATION is made visible.
function TRAINABLE_IMAGE_SEGMENTATION_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TRAINABLE_IMAGE_SEGMENTATION (see VARARGIN)

% Choose default command line output for TRAINABLE_IMAGE_SEGMENTATION
clc;
addpath(genpath('LIBS'));
addpath(genpath('RESOURCES'));

% addpath('\LIBS\OCR\');
% addpath('\LIBS\Bilateral Filtering\');
% addpath('\RESOURCES\Images_Icons\');
ConfigFile = fopen('Config.txt');
TesseractPath = [];
WekaPath = [];
if ConfigFile == -1
    TesseractPath = 'tesseract';
    WekaPath = 'Weka 3.7.lnk';
    OfeliPath = 'RESOURCES\\OFELI'
else
    TesseractPath = fgetl(ConfigFile);
    WekaPath = fgetl(ConfigFile);
    OfeliPath = fgetl(ConfigFile);
end
handles.TesseractPath = TesseractPath;
handles.WekaPath = WekaPath;
handles.OfeliPath = OfeliPath;


vector_clases = [];
handles.Vector_Masks = {};
axes(handles.Ejes_Imagen_Entrada);
axis off;
imshow(imread('\Images_Icons\InputImage.png'));
axes(handles.Ejes_Region_Entrenamiento);
axis off;
imshow(imread('\Images_Icons\IMask.png'));
axes(handles.Ejes_Segmentar);
axis off;
imshow(imread('\Images_Icons\SegMatlab.png'));
axes(handles.Ejes_Segmentar_Weka);
axis off;
imshow(imread('\Images_Icons\SegWeka.png'));

handles.output = hObject;
handles.vectorclases = vector_clases;
handles.FactorResize = 1;

handles.Mask = [];

handles.ImagenGray = [];
handles.ImagenHue = [];
handles.ImagenSat = [];
handles.ImagenBright = [];
handles.ImagenY = [];
handles.ImagenCB = [];
handles.ImagenCR = [];
handles.ImagenRadioRGB = [];
handles.ImagenHessianModule = [];
handles.ImagenHessianTrace = [];
handles.ImagenHessianDeterminant = [];
handles.ImagenHessianFirstEigenvalue = []; 
handles.ImagenHessianSecondEigenvalue = [];
handles.ImagenHessianOrientation = [];
handles.ImagenBilateralFilterHue = [];
handles.ImagenMedian = [];

set(handles.Edit_T_Min, 'Enable', 'off');
set(handles.Edit_T_Max, 'Enable', 'off');
set(handles.Menu_OCR, 'Enable', 'off');


set(handles.Caracteristica1, 'Enable', 'off');
set(handles.Caracteristica2, 'Enable', 'off');
set(handles.Caracteristica3, 'Enable', 'off');
set(handles.Caracteristica4, 'Enable', 'off');
set(handles.Caracteristica5, 'Enable', 'off');
set(handles.Caracteristica6, 'Enable', 'off');
set(handles.Caracteristica7, 'Enable', 'off');
set(handles.Caracteristica8, 'Enable', 'off');
set(handles.Caracteristica9, 'Enable', 'off');
set(handles.Caracteristica10, 'Enable', 'off');
set(handles.Caracteristica11, 'Enable', 'off');
set(handles.Caracteristica12, 'Enable', 'off');
set(handles.Caracteristica13, 'Enable', 'off');
set(handles.Caracteristica14, 'Enable', 'off');
set(handles.Caracteristica15, 'Enable', 'off');
set(handles.Caracteristica16, 'Enable', 'off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TRAINABLE_IMAGE_SEGMENTATION wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TRAINABLE_IMAGE_SEGMENTATION_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Boton_Cargar.
function Boton_Cargar_Callback(hObject, eventdata, handles)
% hObject    handle to Boton_Cargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
[filename pathname] = uigetfile('*.*','Cargar Imagen');
rutaimagen = strcat(pathname, filename);
if (isempty(rutaimagen))
    return;
end
Imagen_Entrada = imread(rutaimagen);
[Alto Ancho Canales] = size(Imagen_Entrada);
handles.Vector_Masks = {};



handles.ImagenGray = [];
set(handles.Caracteristica1, 'Value', 0);
handles.ImagenHue = [];
set(handles.Caracteristica2, 'Value', 0);
handles.ImagenSat = [];
set(handles.Caracteristica3, 'Value', 0);
handles.ImagenBright = [];
set(handles.Caracteristica4, 'Value', 0);
handles.ImagenY = [];
set(handles.Caracteristica5, 'Value', 0);
handles.ImagenCB = [];
set(handles.Caracteristica6, 'Value', 0);
handles.ImagenCR = [];
set(handles.Caracteristica7, 'Value', 0);
handles.ImagenRadioRGB = [];
set(handles.Caracteristica8, 'Value', 0);
handles.ImagenHessianModule = [];
set(handles.Caracteristica9, 'Value', 0);
handles.ImagenHessianTrace = [];
set(handles.Caracteristica10, 'Value', 0);
handles.ImagenHessianDeterminant = [];
set(handles.Caracteristica11, 'Value', 0);
handles.ImagenHessianFirstEigenvalue = [];
set(handles.Caracteristica12, 'Value', 0);
handles.ImagenHessianSecondEigenvalue = [];
set(handles.Caracteristica13, 'Value', 0);
handles.ImagenHessianOrientation = [];
set(handles.Caracteristica14, 'Value', 0);
handles.ImagenBilateralFilterHue = [];
set(handles.Caracteristica15, 'Value', 0);
handles.ImagenMedian = [];
set(handles.Caracteristica16, 'Value', 0);

set(handles.Edit_T_Min, 'Enable', 'on');
set(handles.Edit_T_Max, 'Enable', 'on');
set(handles.Menu_OCR, 'Enable', 'on');

set(handles.Edit_W, 'String', 'off');
set(handles.Edit_H, 'String', 'off');


set(handles.Caracteristica1, 'Enable', 'on');
set(handles.Caracteristica2, 'Enable', 'on');
set(handles.Caracteristica3, 'Enable', 'on');
set(handles.Caracteristica4, 'Enable', 'on');
set(handles.Caracteristica5, 'Enable', 'on');
set(handles.Caracteristica6, 'Enable', 'on');
set(handles.Caracteristica7, 'Enable', 'on');
set(handles.Caracteristica8, 'Enable', 'on');
set(handles.Caracteristica9, 'Enable', 'on');
set(handles.Caracteristica10, 'Enable', 'on');
set(handles.Caracteristica11, 'Enable', 'on');
set(handles.Caracteristica12, 'Enable', 'on');
set(handles.Caracteristica13, 'Enable', 'on');
set(handles.Caracteristica14, 'Enable', 'on');
set(handles.Caracteristica15, 'Enable', 'on');
set(handles.Caracteristica16, 'Enable', 'on');

handles.Mask = [];
vector_clases = [];
handles.Vector_Masks = {};
set(handles.Menu_Clases, 'String', ' ');
set(handles.Edit_Acumulado, 'String', '');
set(handles.Edit_Num_Pix, 'String', '');


handles.rutaimage = rutaimagen;
handles.Image_Original =  Imagen_Entrada;
handles.Image_Input = imresize(Imagen_Entrada, handles.FactorResize);
guidata(hObject, handles);

axes(handles.Ejes_Imagen_Entrada);
imshow(handles.Image_Input);

set(handles.Edit_W, 'String', num2str(size(handles.Image_Input,2)));
set(handles.Edit_H, 'String', num2str(size(handles.Image_Input,1)));
set(handles.Edit_Total_Pixel, 'String', num2str((size(handles.Image_Input,2))*(size(handles.Image_Input,1))));

if get(handles.Menu_OCR,'Value') == 2
    Menu_OCR_Callback(hObject, eventdata, handles);
end



% --- Executes on selection change in Tipo_Seleccion_Puntos.
function Tipo_Seleccion_Puntos_Callback(hObject, eventdata, handles)
% hObject    handle to Tipo_Seleccion_Puntos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tipo_seleccion_puntos = get(handles.Tipo_Seleccion_Puntos,'Value');

switch tipo_seleccion_puntos
    case 1
        h = impoint; pos = wait(h);
    case 2
        h = imline; pos = wait(h);
    case 3
        h = imrect; pos = wait(h);
    case 4
        h = imellipse; pos = wait(h);
    case 5
        h = impoly; pos = wait(h);       
    otherwise
        h = imfreehand; pos = wait(h); 
end

if tipo_seleccion_puntos == 1
   [Alto Ancho Canales] = size(handles.Image_Input);
   handles.Mask = zeros(Alto, Ancho); 
   pos = h.getPosition;
   x = pos(1);
   y = pos(2);
   handles.Mask(round(x), round(y)) = 1;
else
   handles.Mask = h.createMask;  
end

axes(handles.Ejes_Region_Entrenamiento);
imshow(handles.Mask);
s  = regionprops(handles.Mask, 'Area');
set(handles.Edit_Num_Pix, 'String', num2str(s.Area));
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns Tipo_Seleccion_Puntos contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Tipo_Seleccion_Puntos


% --- Executes during object creation, after setting all properties.
function Tipo_Seleccion_Puntos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tipo_Seleccion_Puntos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Menu_Clases.
function Menu_Clases_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Clases (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Menu_Clases
valor_clases = get(handles.Menu_Clases, 'Value');
s  = regionprops(handles.Vector_Masks{valor_clases}, 'Area');
set(handles.Edit_Num_Pix, 'String', num2str(s.Area));
axes(handles.Ejes_Region_Entrenamiento);
imshow(handles.Vector_Masks{valor_clases});

% --- Executes during object creation, after setting all properties.
function Menu_Clases_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Menu_Clases (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Boton_Anadir_Clase.
function Boton_Anadir_Clase_Callback(hObject, eventdata, handles)
% hObject    handle to Boton_Anadir_Clase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (isempty(handles.Mask))
    return;
end
vector_clases = handles.vectorclases;
valor = length(vector_clases)+1;
vector_clases = [vector_clases; valor];
set(handles.Menu_Clases, 'String', num2str(vector_clases));
set(handles.Menu_Clases, 'Value', valor);
handles.vectorclases = vector_clases;

VectorMasks = handles.Vector_Masks;
VectorMasks = [VectorMasks handles.Mask];
handles.Vector_Masks = VectorMasks;
%length(VectorMasks)
Acumulado = 0;
for k=1:length(handles.Vector_Masks)
    s = regionprops(handles.Vector_Masks{k}, 'Area');
    Acumulado = Acumulado + s.Area;
end
set(handles.Edit_Acumulado, 'String', num2str(Acumulado));

guidata(hObject, handles);
% --- Executes on button press in Boton_Borrar_Clase.
function Boton_Borrar_Clase_Callback(hObject, eventdata, handles)
% hObject    handle to Boton_Borrar_Clase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vector_clases = handles.vectorclases;
VectorMasks = handles.Vector_Masks;
if(length(vector_clases)<=1)
    vector_clases=[];
    VectorMasks = {};
    set(handles.Menu_Clases, 'String', ' ');
else
    vector_clases = vector_clases(vector_clases~=length(vector_clases));
    VectorMasks = VectorMasks(1:length(VectorMasks)-1);
    valor = length(vector_clases);
    set(handles.Menu_Clases, 'String', num2str(vector_clases));
    set(handles.Menu_Clases, 'Value', valor);
end
handles.vectorclases = vector_clases;
handles.Vector_Masks = VectorMasks;

Acumulado = 0;
for k=1:length(handles.Vector_Masks)
    s = regionprops(handles.Vector_Masks{k}, 'Area');
    Acumulado = Acumulado + s.Area;
end
if Acumulado == 0
    set(handles.Edit_Acumulado, 'String', '');
else
    set(handles.Edit_Acumulado, 'String', num2str(Acumulado));
end

guidata(hObject, handles);


% --- Executes on button press in Caracteristica1.
function Caracteristica1_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Obteniendo Gray
if(isempty(getfield(handles,'ImagenGray')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       GrayI = rgb2gray(handles.Image_Input);
    else
        GrayI = handles.Image_Input;
    end
    handles.ImagenGray = GrayI;
    guidata(hObject, handles);
    
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imshow(handles.ImagenGray);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica1


% --- Executes on button press in Caracteristica2.
function Caracteristica2_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenHue')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       HSV = rgb2hsv(handles.Image_Input);
    else        
       HSV = rgb2hsv(cat(3, handles.Image_Input, handles.Image_Input, handles.Image_Input));
    end
    handles.ImagenHue = HSV(:,:,1);
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imshow(handles.ImagenHue);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica2


% --- Executes on button press in Caracteristica3.
function Caracteristica3_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenSat')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       HSV = rgb2hsv(handles.Image_Input);
    else        
       HSV = rgb2hsv(cat(3, handles.Image_Input, handles.Image_Input, handles.Image_Input));
    end
    handles.ImagenSat = HSV(:,:,2);
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imshow(handles.ImagenSat);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica3


% --- Executes on button press in Caracteristica4.
function Caracteristica4_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenBright')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       HSV = rgb2hsv(handles.Image_Input);
    else        
       HSV = rgb2hsv(cat(3, handles.Image_Input, handles.Image_Input, handles.Image_Input));
    end
    handles.ImagenBright = HSV(:,:,3);
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imshow(handles.ImagenBright);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica4


% --- Executes on button press in Caracteristica5.
function Caracteristica5_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenY')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       YCBCR = rgb2ycbcr(handles.Image_Input);
    else        
       YCBCR = rgb2ycbcr(cat(3, handles.Image_Input, handles.Image_Input, handles.Image_Input));
    end
    handles.ImagenY = YCBCR(:,:,1);
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imshow(handles.ImagenY);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica5

% --- Executes on button press in Caracteristica6.
function Caracteristica6_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenCB')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       YCBCR = rgb2ycbcr(handles.Image_Input);
    else        
       YCBCR = rgb2ycbcr(cat(3, handles.Image_Input, handles.Image_Input, handles.Image_Input));
    end
    handles.ImagenCB = YCBCR(:,:,2);
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imshow(handles.ImagenCB);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica6


% --- Executes on button press in Caracteristica7.
function Caracteristica7_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenCR')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       YCBCR = rgb2ycbcr(handles.Image_Input);
    else        
       YCBCR = rgb2ycbcr(cat(3, handles.Image_Input, handles.Image_Input, handles.Image_Input));
    end
    handles.ImagenCR = YCBCR(:,:,3);
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imshow(handles.ImagenCR);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica7


% --- Executes on button press in Caracteristica8.
function Caracteristica8_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenRadioRGB')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       RadioRGB = sqrt((double(handles.Image_Input(:,:,1)).^2)+ (double(handles.Image_Input(:,:,2)).^2) + (double(handles.Image_Input(:,:,3)).^2));     
    else        
       RadioRGB = double(handles.Image_Input);
    end
    handles.ImagenRadioRGB = RadioRGB;
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imagesc(handles.ImagenRadioRGB);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica8

% --- Executes on button press in Caracteristica9.
function Caracteristica9_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenHessianModule')))
    [Alto Ancho Canales] = size(handles.Image_Input);    
    if(Canales == 3)
       Gray = rgb2gray(handles.Image_Input);     
    else        
       Gray = handles.Image_Input;
    end
    [gx, gy] = gradient(double(Gray));
    [gxx, gxy] = gradient(gx);
    [gyx, gyy] = gradient(gy);
    HessianModule = sqrt((gxx.^2) + (gxy.*gyx) + (gyy.^2));
    handles.ImagenHessianModule = HessianModule;
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imagesc(handles.ImagenHessianModule);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica9


% --- Executes on button press in Caracteristica10.
function Caracteristica10_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenHessianTrace')))
    [Alto Ancho Canales] = size(handles.Image_Input);    
    if(Canales == 3)
       Gray = rgb2gray(handles.Image_Input);     
    else        
       Gray = handles.Image_Input;
    end
    [gx, gy] = gradient(double(Gray));
    [gxx, gxy] = gradient(gx);
    [gyx, gyy] = gradient(gy);
    HessianTrace = gxx + gyy;
    handles.ImagenHessianTrace = HessianTrace;
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imagesc(handles.ImagenHessianTrace);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica10


% --- Executes on button press in Caracteristica11.
function Caracteristica11_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenHessianDeterminant')))
    [Alto Ancho Canales] = size(handles.Image_Input);    
    if(Canales == 3)
       Gray = rgb2gray(handles.Image_Input);     
    else        
       Gray = handles.Image_Input;
    end
    [gx, gy] = gradient(double(Gray));
    [gxx, gxy] = gradient(gx);
    [gyx, gyy] = gradient(gy);
    HessianDeterminant = (gxx.*gyy) - (gxy.*gyx);
    handles.ImagenHessianDeterminant = HessianDeterminant;
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imagesc(handles.ImagenHessianDeterminant);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica11


% --- Executes on button press in Caracteristica12.
function Caracteristica12_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenHessianFirstEigenvalue')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       Gray = rgb2gray(handles.Image_Input);     
    else        
       Gray = handles.Image_Input;
    end
    [gx, gy] = gradient(double(Gray));
    [gxx, gxy] = gradient(gx);
    [gyx, gyy] = gradient(gy);
    HessianFirstEigenvalue = abs(((gxx + gyy)/2)+(sqrt(((4*(gxy.^2))-((gxx-gyy).^2))/2)));
    handles.ImagenHessianFirstEigenvalue = HessianFirstEigenvalue;
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imagesc(handles.ImagenHessianFirstEigenvalue);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica12


% --- Executes on button press in Caracteristica13.
function Caracteristica13_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenHessianSecondEigenvalue')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       Gray = rgb2gray(handles.Image_Input);     
    else        
       Gray = handles.Image_Input;
    end
    [gx, gy] = gradient(double(Gray));
    [gxx, gxy] = gradient(gx);
    [gyx, gyy] = gradient(gy);
    HessianSecondEigenvalue = abs(((gxx + gyy)/2)-(sqrt(((4*(gxy.^2))-((gxx-gyy).^2))/2)));
    handles.ImagenHessianSecondEigenvalue = HessianSecondEigenvalue;
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imagesc(handles.ImagenHessianSecondEigenvalue);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica13

% --- Executes on button press in Caracteristica14.
function Caracteristica14_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenHessianOrientation')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       Gray = rgb2gray(handles.Image_Input);     
    else        
       Gray = handles.Image_Input;
    end
    [gx, gy] = gradient(double(Gray));
    [gxx, gxy] = gradient(gx);
    [gyx, gyy] = gradient(gy);
    
    if isreal(acos(sqrt(((4*(gxy.^2))-((gxx-gyy).^2)))))
        HessianOrientation = acos(sqrt(((4*(gxy.^2))-((gxx-gyy).^2))));
    else
        HessianOrientation = abs(acos(sqrt(((4*(gxy.^2))-((gxx-gyy).^2)))));
    end
    
    handles.ImagenHessianOrientation = HessianOrientation;
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imagesc(handles.ImagenHessianOrientation);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica14

% --- Executes on button press in Caracteristica15.
function Caracteristica15_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenBilateralFilterHue')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       BFilterHue = BilateralFilterHue(handles.Image_Input, 5, [3 0.1]);     
    else        
       BFilterHue = BilateralFilterHue(cat(3, handles.Image_Input, handles.Image_Input, handles.Image_Input), 5, [3 0.1]);
    end
    handles.ImagenBilateralFilterHue = BFilterHue;
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imshow(handles.ImagenBilateralFilterHue);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica15

% --- Executes on button press in Caracteristica16.
function Caracteristica16_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristica16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(getfield(handles,'ImagenMedian')))
    [Alto Ancho Canales] = size(handles.Image_Input);
    if(Canales == 3)
       Median = medfilt2(rgb2gray(handles.Image_Input));     
    else        
       Median = medfilt2(handles.Image_Input);
    end
    handles.ImagenMedian = Median;
    guidata(hObject, handles);
end
if (get(handles.Checkbox_Image_Caractersitica, 'Value') == 1) && (get(hObject, 'Value'))
    figure, imshow(handles.ImagenMedian);
end
% Hint: get(hObject,'Value') returns toggle state of Caracteristica16


function Edit_Num_Pix_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Num_Pix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Num_Pix as text
%        str2double(get(hObject,'String')) returns contents of Edit_Num_Pix as a double


% --- Executes during object creation, after setting all properties.
function Edit_Num_Pix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Num_Pix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Ver_Feature_Space.
function Ver_Feature_Space_Callback(hObject, eventdata, handles)
% hObject    handle to Ver_Feature_Space (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor_caracteristica1 = get(handles.Caracteristica1, 'Value');
valor_caracteristica2 = get(handles.Caracteristica2, 'Value');
valor_caracteristica3 = get(handles.Caracteristica3, 'Value');
valor_caracteristica4 = get(handles.Caracteristica4, 'Value');
valor_caracteristica5 = get(handles.Caracteristica5, 'Value');
valor_caracteristica6 = get(handles.Caracteristica6, 'Value');
valor_caracteristica7 = get(handles.Caracteristica7, 'Value');
valor_caracteristica8 = get(handles.Caracteristica8, 'Value');

valor_caracteristica9 = get(handles.Caracteristica9, 'Value');
valor_caracteristica10 = get(handles.Caracteristica10, 'Value');
valor_caracteristica11 = get(handles.Caracteristica11, 'Value');
valor_caracteristica12 = get(handles.Caracteristica12, 'Value');
valor_caracteristica13 = get(handles.Caracteristica13, 'Value');
valor_caracteristica14 = get(handles.Caracteristica14, 'Value');
valor_caracteristica15 = get(handles.Caracteristica15, 'Value');
valor_caracteristica16 = get(handles.Caracteristica16, 'Value');

vector_valores_caracteristicas = [valor_caracteristica1 valor_caracteristica2 ...
                                  valor_caracteristica3 valor_caracteristica4 ...
                                  valor_caracteristica5 valor_caracteristica6 ...
                                  valor_caracteristica7 valor_caracteristica8 ...
                                  valor_caracteristica9 valor_caracteristica10 ...
                                  valor_caracteristica11 valor_caracteristica12 ...
                                  valor_caracteristica13 valor_caracteristica14 ...
                                  valor_caracteristica15 valor_caracteristica16];

if (length(find(vector_valores_caracteristicas)) > 3 || length(find(vector_valores_caracteristicas)) == 0)
    uiwait(errordlg('El número de características debe ser entre 1 y 3','Excede Dimensión'));
    return;
end

if (length(handles.Vector_Masks)<2)
    uiwait(errordlg('El número de clases seleccionadas debe ser mayor a 1','Número Clases'));
    return;    
end

handles.MatrixCaracteristica=Obtener_Matrix_Caracteristica(handles, hObject);
guidata(hObject, handles);
graficar_espacio_caracteristico(handles, hObject);
%disp('Se puede graficar');

function graficar_espacio_caracteristico(handles, hObject)
figure;
[Num_Caracteristicas Num_Patrones] = size(handles.MatrixCaracteristica);
% t=1:5;
% x=t;
% y=t.*t;
% z=t;
%length(handles.Vector_Masks)
numero_patr=1;
for k=1:length(handles.Vector_Masks)
    switch Num_Caracteristicas
        case 1
            hist(handles.MatrixCaracteristica(1,numero_patr:-1 + numero_patr+ length(find(handles.Vector_Masks{k}))));
            h = findobj(gca,'Type','patch');
            set(h,'FaceColor',[rand() rand() rand()],'EdgeColor','r')
            hold on;
        case 2
            tipo = rand_caracter();
            hold on;
            plot(handles.MatrixCaracteristica(1,numero_patr:-1 + numero_patr+ length(find(handles.Vector_Masks{k}))), ...
                 handles.MatrixCaracteristica(2,numero_patr:-1 + numero_patr+length(find(handles.Vector_Masks{k}))), tipo, 'Color',[rand() rand() rand()]);
            grid on;
            
            %legend('Clase '+ num2str(k));
        otherwise
            tipo = rand_caracter();
            hold on;
            plot3(handles.MatrixCaracteristica(1,numero_patr:-1 + numero_patr+ length(find(handles.Vector_Masks{k}))), ...
                 handles.MatrixCaracteristica(2,numero_patr:-1 + numero_patr+length(find(handles.Vector_Masks{k}))), ...
                 handles.MatrixCaracteristica(3,numero_patr:-1 + numero_patr+length(find(handles.Vector_Masks{k}))), tipo, 'Color',[rand() rand() rand()]);
            rotate3d on;
            grid on;
    end
    numero_patr = numero_patr + length(find(handles.Vector_Masks{k}));
end

function [tipo] = rand_caracter()
num = round(13*rand());
car = '.';
switch num
    case 1
        car = '.';
    case 2
        car = 'o';
    case 3
        car = 'x';
    case 4
        car = '+';
    case 5
        car = '*';
    case 6
        car = 's';
    case 7
        car = 'd';
    case 8
        car = 'v';
    case 9
        car = '>';
    case 10
        car = '<';
    case 11
        car = 'p';
    case 12
        car = 'h';
    otherwise
        car = '^';     
end
tipo = car;

function [Matrix_Caracteristica] = Obtener_Matrix_Caracteristica(handles, hObject)
valor_caracteristica1 = get(handles.Caracteristica1, 'Value');
valor_caracteristica2 = get(handles.Caracteristica2, 'Value');
valor_caracteristica3 = get(handles.Caracteristica3, 'Value');
valor_caracteristica4 = get(handles.Caracteristica4, 'Value');
valor_caracteristica5 = get(handles.Caracteristica5, 'Value');
valor_caracteristica6 = get(handles.Caracteristica6, 'Value');
valor_caracteristica7 = get(handles.Caracteristica7, 'Value');
valor_caracteristica8 = get(handles.Caracteristica8, 'Value');

valor_caracteristica9 = get(handles.Caracteristica9, 'Value');
valor_caracteristica10 = get(handles.Caracteristica10, 'Value');
valor_caracteristica11 = get(handles.Caracteristica11, 'Value');
valor_caracteristica12 = get(handles.Caracteristica12, 'Value');
valor_caracteristica13 = get(handles.Caracteristica13, 'Value');
valor_caracteristica14 = get(handles.Caracteristica14, 'Value');
valor_caracteristica15 = get(handles.Caracteristica15, 'Value');
valor_caracteristica16 = get(handles.Caracteristica16, 'Value');

vector_valores_caracteristicas = [valor_caracteristica1 valor_caracteristica2 ...
                                  valor_caracteristica3 valor_caracteristica4 ...
                                  valor_caracteristica5 valor_caracteristica6 ...
                                  valor_caracteristica7 valor_caracteristica8 ...
                                  valor_caracteristica9 valor_caracteristica10 ...
                                  valor_caracteristica11 valor_caracteristica12 ...
                                  valor_caracteristica13 valor_caracteristica14 ...
                                  valor_caracteristica15 valor_caracteristica16];

numero_patrones = 0;                              
for i=1:length(handles.Vector_Masks)
    s  = regionprops(handles.Vector_Masks{i}, 'Area');
    numero_patrones = numero_patrones + s.Area;
end

Matrix_Carac = zeros(length(find(vector_valores_caracteristicas)), numero_patrones);

%%%%%%%%%%%%%
contador = 1;
if (valor_caracteristica1 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica1(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica2 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica2(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica3 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica3(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica4 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica4(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica5 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica5(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica6 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica6(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica7 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica7(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica8 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica8(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica9 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica9(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica10 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica10(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica11 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica11(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica12 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica12(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica13 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica13(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica14 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica14(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica15 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica15(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica16 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica16(handles, hObject, numero_patrones);
    contador = contador + 1;
end
%%%%%%%%%%%%%

Matrix_Caracteristica = Matrix_Carac;
%save('SalidaMatrixCarac.mat', 'Matrix_Carac');

function [FilaCaracteristica] = Obtener_Fila_Caracteristica1(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica1_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;



function [FilaCaracteristica] = Obtener_Fila_Caracteristica2(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica2_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;


function [FilaCaracteristica] = Obtener_Fila_Caracteristica3(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica3_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;


function [FilaCaracteristica] = Obtener_Fila_Caracteristica4(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica4_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;

function [FilaCaracteristica] = Obtener_Fila_Caracteristica5(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica5_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;

function [FilaCaracteristica] = Obtener_Fila_Caracteristica6(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica6_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;

function [FilaCaracteristica] = Obtener_Fila_Caracteristica7(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica7_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;

function [FilaCaracteristica] = Obtener_Fila_Caracteristica8(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica8_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;


function [FilaCaracteristica] = Obtener_Fila_Caracteristica9(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica9_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;

function [FilaCaracteristica] = Obtener_Fila_Caracteristica10(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica10_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;

function [FilaCaracteristica] = Obtener_Fila_Caracteristica11(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica11_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;

function [FilaCaracteristica] = Obtener_Fila_Caracteristica12(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica12_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;

function [FilaCaracteristica] = Obtener_Fila_Caracteristica13(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica13_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;

function [FilaCaracteristica] = Obtener_Fila_Caracteristica14(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica14_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;

function [FilaCaracteristica] = Obtener_Fila_Caracteristica15(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica15_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;

function [FilaCaracteristica] = Obtener_Fila_Caracteristica16(handles, hObject, numero_patrones)
Fila = zeros(1,numero_patrones);
numero_patr=0;
for k=1:length(handles.Vector_Masks)
    [f c] = find(handles.Vector_Masks{k});
    for j = 1:length(f)
        Fila(j+numero_patr) = Obtener_Caracteristica16_Pixel_XY(handles, hObject, f(j), c(j));
    end
    numero_patr = numero_patr + length(f);
end
FilaCaracteristica = Fila;


function [CaracteristicaPixel] = Obtener_Caracteristica1_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenGray(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica2_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenHue(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica3_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenSat(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica4_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenBright(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica5_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenY(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica6_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenCB(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica7_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenCR(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica8_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenRadioRGB(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica9_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenHessianModule(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica10_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenHessianTrace(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica11_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenHessianDeterminant(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica12_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenHessianFirstEigenvalue(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica13_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenHessianSecondEigenvalue(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica14_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenHessianOrientation(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica15_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenBilateralFilterHue(y,x));

function [CaracteristicaPixel] = Obtener_Caracteristica16_Pixel_XY(handles, hObject, y, x)
CaracteristicaPixel = double(handles.ImagenMedian(y,x));


% --- Executes on button press in TrainBoton.
function TrainBoton_Callback(hObject, eventdata, handles)
% hObject    handle to TrainBoton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor_caracteristica1 = get(handles.Caracteristica1, 'Value');
valor_caracteristica2 = get(handles.Caracteristica2, 'Value');
valor_caracteristica3 = get(handles.Caracteristica3, 'Value');
valor_caracteristica4 = get(handles.Caracteristica4, 'Value');
valor_caracteristica5 = get(handles.Caracteristica5, 'Value');
valor_caracteristica6 = get(handles.Caracteristica6, 'Value');
valor_caracteristica7 = get(handles.Caracteristica7, 'Value');
valor_caracteristica8 = get(handles.Caracteristica8, 'Value');

valor_caracteristica9 = get(handles.Caracteristica9, 'Value');
valor_caracteristica10 = get(handles.Caracteristica10, 'Value');
valor_caracteristica11 = get(handles.Caracteristica11, 'Value');
valor_caracteristica12 = get(handles.Caracteristica12, 'Value');
valor_caracteristica13 = get(handles.Caracteristica13, 'Value');
valor_caracteristica14 = get(handles.Caracteristica14, 'Value');
valor_caracteristica15 = get(handles.Caracteristica15, 'Value');
valor_caracteristica16 = get(handles.Caracteristica16, 'Value');

vector_valores_caracteristicas = [valor_caracteristica1 valor_caracteristica2 ...
                                  valor_caracteristica3 valor_caracteristica4 ...
                                  valor_caracteristica5 valor_caracteristica6 ...
                                  valor_caracteristica7 valor_caracteristica8 ...
                                  valor_caracteristica9 valor_caracteristica10 ...
                                  valor_caracteristica11 valor_caracteristica12 ...
                                  valor_caracteristica13 valor_caracteristica14 ...
                                  valor_caracteristica15 valor_caracteristica16];

if (length(find(vector_valores_caracteristicas)) < 2 )
    uiwait(errordlg('El número de características debe ser mayor que 1','Número de Características'));
    return;
end

clasificador_numero = get(handles.ClasificadorMenu, 'Value');
[handles.MatrixCarcteristicaEntrenar handles.MatrixCarcteristicaObjetivos] ...
     = Obtener_Matrix_Caractersitica_Entrenar_Objetivos(handles, hObject);

guidata(hObject, handles);

switch clasificador_numero
    case 1
        handles.Red_Neuronal = Clasificador1(hObject, handles);
    case 2
        handles.RBF = Clasificador2(hObject, handles);
    case 3
        handles.PNN = Clasificador3(hObject, handles);
    otherwise
        Clasificador(hObject, handles);
end
guidata(hObject, handles);


function  [MatrixTrain Objetivos] = Obtener_Matrix_Caractersitica_Entrenar_Objetivos(handles, hObject)
valor_caracteristica1 = get(handles.Caracteristica1, 'Value');
valor_caracteristica2 = get(handles.Caracteristica2, 'Value');
valor_caracteristica3 = get(handles.Caracteristica3, 'Value');
valor_caracteristica4 = get(handles.Caracteristica4, 'Value');
valor_caracteristica5 = get(handles.Caracteristica5, 'Value');
valor_caracteristica6 = get(handles.Caracteristica6, 'Value');
valor_caracteristica7 = get(handles.Caracteristica7, 'Value');
valor_caracteristica8 = get(handles.Caracteristica8, 'Value');

valor_caracteristica9 = get(handles.Caracteristica9, 'Value');
valor_caracteristica10 = get(handles.Caracteristica10, 'Value');
valor_caracteristica11 = get(handles.Caracteristica11, 'Value');
valor_caracteristica12 = get(handles.Caracteristica12, 'Value');
valor_caracteristica13 = get(handles.Caracteristica13, 'Value');
valor_caracteristica14 = get(handles.Caracteristica14, 'Value');
valor_caracteristica15 = get(handles.Caracteristica15, 'Value');
valor_caracteristica16 = get(handles.Caracteristica16, 'Value');

vector_valores_caracteristicas = [valor_caracteristica1 valor_caracteristica2 ...
                                  valor_caracteristica3 valor_caracteristica4 ...
                                  valor_caracteristica5 valor_caracteristica6 ...
                                  valor_caracteristica7 valor_caracteristica8 ...
                                  valor_caracteristica9 valor_caracteristica10 ...
                                  valor_caracteristica11 valor_caracteristica12 ...
                                  valor_caracteristica13 valor_caracteristica14 ...
                                  valor_caracteristica15 valor_caracteristica16];


                              
numero_patrones = 0;                              
numero_caracteristicas = length(find(vector_valores_caracteristicas));
numero_clases = length(handles.Vector_Masks);

for i=1:length(handles.Vector_Masks)
    s  = regionprops(handles.Vector_Masks{i}, 'Area');
    numero_patrones = numero_patrones + s.Area;

end

Matrix_Carac = zeros(numero_caracteristicas, numero_patrones);
Matrix_Objetivos = zeros(numero_clases, numero_patrones);

contador = 1;
for i=1:length(handles.Vector_Masks)
    vector_objetivo = [];
    for j=1:numero_clases
        if i == j
           vector_objetivo = [vector_objetivo; 1];
        else
            vector_objetivo = [vector_objetivo; -1];
        end
    end      
    s  = regionprops(handles.Vector_Masks{i}, 'Area');
    for k=contador:contador + s.Area - 1 
        Matrix_Objetivos(:,k) = vector_objetivo;
    end   
    contador = contador + s.Area;
end


%%%%%%%%%%%%%
contador = 1;
if (valor_caracteristica1 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica1(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica2 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica2(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica3 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica3(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica4 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica4(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica5 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica5(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica6 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica6(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica7 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica7(handles, hObject, numero_patrones);    
    contador = contador + 1;
end

if (valor_caracteristica8 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica8(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica9 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica9(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica10 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica10(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica11 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica11(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica12 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica12(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica13 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica13(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica14 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica14(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica15 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica15(handles, hObject, numero_patrones);
    contador = contador + 1;
end

if (valor_caracteristica16 == 1)
    Matrix_Carac(contador, :) = Obtener_Fila_Caracteristica16(handles, hObject, numero_patrones);
    contador = contador + 1;
end

%%%%%%%%%%%%%


MatrixTrain = Matrix_Carac;
Objetivos = Matrix_Objetivos;

%save('Objetivos.mat', 'Objetivos');

% --- Executes on selection change in ClasificadorMenu.
function ClasificadorMenu_Callback(hObject, eventdata, handles)
% hObject    handle to ClasificadorMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ClasificadorMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ClasificadorMenu


% --- Executes during object creation, after setting all properties.
function ClasificadorMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ClasificadorMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Clasificador(hObject, handles)
disp('Waiting for codingg :)');

function [modelo] = Clasificador1(hObject, handles)
k=3;
n=3;
net = newff(handles.MatrixCarcteristicaEntrenar, handles.MatrixCarcteristicaObjetivos,[k n],{},'trainbfg');
net.divideParam.trainRatio = 1;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;
net = train(net,handles.MatrixCarcteristicaEntrenar ,handles.MatrixCarcteristicaObjetivos);
ClassificationMatrix = net(handles.MatrixCarcteristicaEntrenar);
figure;
plotconfusion(handles.MatrixCarcteristicaObjetivos, ClassificationMatrix);
modelo = net;


function [modelo] = Clasificador2(hObject, handles)
K=40;
Ki=5;
goal = 0;
spr = 0.8;
net = newrb(handles.MatrixCarcteristicaEntrenar,handles.MatrixCarcteristicaObjetivos,goal,spr,K,Ki);
ClassificationMatrix = net(handles.MatrixCarcteristicaEntrenar);
figure;
plotconfusion(handles.MatrixCarcteristicaObjetivos, ClassificationMatrix);
modelo = net;

function [modelo] = Clasificador3(hObject, handles)
spr = 0.242;
net = newpnn(handles.MatrixCarcteristicaEntrenar,handles.MatrixCarcteristicaObjetivos,spr);
ClassificationMatrix = net(handles.MatrixCarcteristicaEntrenar);
figure;
fprintf('Num of neurons = %d\n',net.layers{1}.size)
plotconfusion(handles.MatrixCarcteristicaObjetivos, ClassificationMatrix);
modelo = net;

% --- Executes on button press in Clasificar_Imagen.
function Clasificar_Imagen_Callback(hObject, eventdata, handles)
% hObject    handle to Clasificar_Imagen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clasificador_numero = get(handles.ClasificadorMenu, 'Value');
switch clasificador_numero
    case 1
        if(~isfield(handles, 'Red_Neuronal'))
            return;
        else
            ClasificarImagen(handles, hObject, 1);
        end
    case 2
        if(~isfield(handles, 'RBF'))
            return;
        else
            ClasificarImagen(handles, hObject, 2);
        end
        
    otherwise
        if(~isfield(handles, 'PNN'))
            return;
        else
            ClasificarImagen(handles, hObject, 3);
        end     
end

function ClasificarImagen(handles, hObject, opcion)
[Alto Ancho Canales] = size(handles.Image_Input);
Image_Label = zeros(Alto, Ancho);
Image_Label_Vector = zeros(1, Ancho*Alto);

valor_caracteristica1 = get(handles.Caracteristica1, 'Value');
valor_caracteristica2 = get(handles.Caracteristica2, 'Value');
valor_caracteristica3 = get(handles.Caracteristica3, 'Value');
valor_caracteristica4 = get(handles.Caracteristica4, 'Value');
valor_caracteristica5 = get(handles.Caracteristica5, 'Value');
valor_caracteristica6 = get(handles.Caracteristica6, 'Value');
valor_caracteristica7 = get(handles.Caracteristica7, 'Value');
valor_caracteristica8 = get(handles.Caracteristica8, 'Value');

valor_caracteristica9 = get(handles.Caracteristica9, 'Value');
valor_caracteristica10 = get(handles.Caracteristica10, 'Value');
valor_caracteristica11 = get(handles.Caracteristica11, 'Value');
valor_caracteristica12 = get(handles.Caracteristica12, 'Value');
valor_caracteristica13 = get(handles.Caracteristica13, 'Value');
valor_caracteristica14 = get(handles.Caracteristica14, 'Value');
valor_caracteristica15 = get(handles.Caracteristica15, 'Value');
valor_caracteristica16 = get(handles.Caracteristica16, 'Value');

vector_valores_caracteristicas = [valor_caracteristica1 valor_caracteristica2 ...
                                  valor_caracteristica3 valor_caracteristica4 ...
                                  valor_caracteristica5 valor_caracteristica6 ...
                                  valor_caracteristica7 valor_caracteristica8 ...
                                  valor_caracteristica9 valor_caracteristica10 ...
                                  valor_caracteristica11 valor_caracteristica12 ...
                                  valor_caracteristica13 valor_caracteristica14 ...
                                  valor_caracteristica15 valor_caracteristica16];
                              
if (length(find(vector_valores_caracteristicas)) < 2 )
    uiwait(errordlg('El número de características debe ser mayor que 1','Número de Características'));
    return;
end

opcion_paralelo = get(handles.Checkbox_Paralela, 'Value');
puede_paralelo = 0;
if(opcion_paralelo)
    if (isfunction('matlabpool'))
        % Start labs if necessary.
        sz = matlabpool('size');
        if (sz ==0)
            matlabpool('open');
        end
        % Check we got some now.
        sz = matlabpool('size');
        if (sz ==0)
            disp('Cant run parallel workers'); 
            %error('Failed to open parallel workers'); 
        else
            fprintf('Running on %d workers\n', sz);
            puede_paralelo = 1;
        end
    end
end
% parfor i=1:Alto
%     for j=1:Ancho
tic;
% y=1;
%Primer Ejecución paralela 637s 100x100
%Segunda Ejecución paralela 591s 100x100
if opcion_paralelo == 1 && puede_paralelo ==1
    disp('Running Parallel...');
    opcion_clasificador_menu = get(handles.ClasificadorMenu, 'Value');
    parfor i=1:Alto*Ancho
        
        if (mod(i,Ancho) == 0)
            x = Ancho;
        else
            x = mod(i,Ancho);
        end
        
        contador = 0;
        while x + contador*Ancho <=i
            contador = contador +1;
        end
        y = contador;
        
        patron_pixel = [];
        %contador = 0;
        if (valor_caracteristica1 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica1_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica2 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica2_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica3 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica3_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica4 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica4_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica5 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica5_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica6 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica6_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica7 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica7_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica8 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica8_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica9 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica9_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica10 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica10_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica11 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica11_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica12 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica12_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica13 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica13_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica14 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica14_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica15 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica15_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica16 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica16_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        
        
        %n= (Ancho*(i-1))+j;
        if(opcion_clasificador_menu==1)
            Image_Label_Vector(i) = vec2ind(handles.Red_Neuronal(patron_pixel));
        end
        if(opcion_clasificador_menu==2)
            Image_Label_Vector(i) = vec2ind(handles.RBF(patron_pixel));
        end
        if(opcion_clasificador_menu==3)
            Image_Label_Vector(i) = vec2ind(handles.PNN(patron_pixel));
        end
    end
else
    disp('Running Serial...')
    for i=1:Alto*Ancho
        
        if (mod(i,Ancho) == 0)
            x = Ancho;
        else
            x = mod(i,Ancho);
        end
        
        contador = 0;
        while x + contador*Ancho <=i
            contador = contador +1;
        end
        y = contador;
        
        patron_pixel = [];
        %contador = 0;
        if (valor_caracteristica1 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica1_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica2 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica2_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica3 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica3_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica4 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica4_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica5 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica5_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica6 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica6_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica7 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica7_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica8 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica8_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica9 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica9_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica10 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica10_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica11 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica11_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica12 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica12_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica13 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica13_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica14 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica14_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica15 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica15_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        if (valor_caracteristica16 == 1)
            patron_pixel = [patron_pixel; Obtener_Caracteristica16_Pixel_XY(handles, hObject, y, x)];
            %contador = contador + 1;
        end
        
        %n= (Ancho*(i-1))+j;
        if(get(handles.ClasificadorMenu, 'Value')==1)
            Image_Label_Vector(i) = vec2ind(handles.Red_Neuronal(patron_pixel));
        end
        if(get(handles.ClasificadorMenu, 'Value')==2)
            Image_Label_Vector(i) = vec2ind(handles.RBF(patron_pixel));
        end
        if(get(handles.ClasificadorMenu, 'Value')==3)
            Image_Label_Vector(i) = vec2ind(handles.PNN(patron_pixel));
        end
    end
end

toc

disp ('Arrangin pixels in matrix via serial for')
tic;
for i = 1:Ancho*Alto
        if (mod(i,Ancho) == 0)
            x = Ancho;
        else
            x = mod(i,Ancho);
        end
        
        contador = 0;
        while x + contador*Ancho <=i
            contador = contador +1;
        end
        y = contador;  
        Image_Label(y,x) = Image_Label_Vector(i);
end
toc


axes(handles.Ejes_Segmentar);
handles.ImageSegMatlab = label2rgb(uint8(Image_Label));
imshow(label2rgb(uint8(Image_Label)));
guidata(hObject, handles);

    



function Edit_T_Min_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_T_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_T_Min as text
%        str2double(get(hObject,'String')) returns contents of Edit_T_Min as a double


% --- Executes during object creation, after setting all properties.
function Edit_T_Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_T_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_T_Max_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_T_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_T_Max as text
%        str2double(get(hObject,'String')) returns contents of Edit_T_Max as a double


% --- Executes during object creation, after setting all properties.
function Edit_T_Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_T_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Menu_OCR.
function Menu_OCR_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_OCR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor_menu = get(handles.Menu_OCR, 'Value');

if valor_menu == 2
    rect1 = [285 35 30 22]; % [x, y, Alto, Ancho];
    rect2 = [285 180 30 22]; % [x, y, Alto, Ancho];
    [Min Max] = Obtener_Temperatura_OCR(handles, rect1, rect2);
    set(handles.Edit_T_Min, 'String', Min);
    set(handles.Edit_T_Max, 'String', Max);
    set(handles.Edit_T_Min, 'Enable', 'off');
    set(handles.Edit_T_Max, 'Enable', 'off');
    
end

if valor_menu == 1
    set(handles.Edit_T_Min, 'Enable', 'on');
    set(handles.Edit_T_Max, 'Enable', 'on');
    %set(handles.Edit_T_Min, 'String', '');
    %set(handles.Edit_T_Max, 'String', '');
    
end

% Hints: contents = cellstr(get(hObject,'String')) returns Menu_OCR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Menu_OCR

function [Min Max] = Obtener_Temperatura_OCR(handles, rect1, rect2)
Min = 'Null';
Max = 'Null';

[Alto Ancho Canales] = size(handles.Image_Input);

if (rect1(1) > Ancho) || ((rect1(1) + rect1(4)) > Ancho)
    return;
end
if (rect1(2) > Alto) || ((rect1(2) + rect1(3)) > Alto)
    return;
end
if (rect2(1) > Ancho) || ((rect2(1) + rect2(4)) > Ancho)
    return;
end
if (rect2(2) > Alto) || ((rect2(2) + rect2(3)) > Alto)
    return;
end

Min = 'Passed';
Max = 'Passed';

SubImageMax = imcrop(handles.Image_Input, rect1);
SubImageMin = imcrop(handles.Image_Input, rect2);

%%%%%%%%%%
imagen  = SubImageMax;
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end
imagen = 255 - imagen;
threshold = 0.4;
imagen =~im2bw(imagen,threshold);
imagen = bwareaopen(imagen,5);
SubImageMax = ~imagen; 
%%%%%%%%%%
%%%%%%%%%%
imagen  = SubImageMin;
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end
imagen = 255 - imagen;
threshold = 0.4;
imagen =~im2bw(imagen,threshold);
imagen = bwareaopen(imagen,5);
SubImageMin = ~imagen; 
%%%%%%%%%%



SubImageMaxResized  = imresize(SubImageMax, 20);
SubImageMinResized  = imresize(SubImageMin, 20);

imwrite(SubImageMaxResized, 'NumMax.tif');
imwrite(SubImageMinResized, 'NumMin.tif');

system(strcat(handles.TesseractPath, ' NumMax.tif', ' outputMax'));
clc;
system(strcat(handles.TesseractPath, ' NumMin.tif', ' outputMin'));
clc;
filenameMin = 'outputMin.txt';
filenameMax = 'outputMax.txt';
delimiterIn = ' ';

TemMin = importdata(filenameMin,delimiterIn);
TemMax = importdata(filenameMax,delimiterIn);

if isnumeric(TemMin)
    Min = TemMin;
else
    Min = ocr(SubImageMin);
end
if isnumeric(TemMax)
    Max = TemMax;
else
    Max = ocr(SubImageMax);
end


% --- Executes during object creation, after setting all properties.
function Menu_OCR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Menu_OCR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Boton_Weka.
function Boton_Weka_Callback(hObject, eventdata, handles)
% hObject    handle to Boton_Weka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
system(handles.WekaPath);


% --- Executes on button press in Export_ARFF_Boton.
function Export_ARFF_Boton_Callback(hObject, eventdata, handles)
% hObject    handle to Export_ARFF_Boton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to TrainBoton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor_caracteristica1 = get(handles.Caracteristica1, 'Value');
valor_caracteristica2 = get(handles.Caracteristica2, 'Value');
valor_caracteristica3 = get(handles.Caracteristica3, 'Value');
valor_caracteristica4 = get(handles.Caracteristica4, 'Value');
valor_caracteristica5 = get(handles.Caracteristica5, 'Value');
valor_caracteristica6 = get(handles.Caracteristica6, 'Value');
valor_caracteristica7 = get(handles.Caracteristica7, 'Value');
valor_caracteristica8 = get(handles.Caracteristica8, 'Value');

valor_caracteristica9 = get(handles.Caracteristica9, 'Value');
valor_caracteristica10 = get(handles.Caracteristica10, 'Value');
valor_caracteristica11 = get(handles.Caracteristica11, 'Value');
valor_caracteristica12 = get(handles.Caracteristica12, 'Value');
valor_caracteristica13 = get(handles.Caracteristica13, 'Value');
valor_caracteristica14 = get(handles.Caracteristica14, 'Value');
valor_caracteristica15 = get(handles.Caracteristica15, 'Value');
valor_caracteristica16 = get(handles.Caracteristica16, 'Value');

vector_valores_caracteristicas = [valor_caracteristica1 valor_caracteristica2 ...
                                  valor_caracteristica3 valor_caracteristica4 ...
                                  valor_caracteristica5 valor_caracteristica6 ...
                                  valor_caracteristica7 valor_caracteristica8 ...
                                  valor_caracteristica9 valor_caracteristica10 ...
                                  valor_caracteristica11 valor_caracteristica12 ...
                                  valor_caracteristica13 valor_caracteristica14 ...
                                  valor_caracteristica15 valor_caracteristica16];

if (length(find(vector_valores_caracteristicas)) < 2 )
    uiwait(errordlg('El número de características debe ser mayor que 1','Número de Características'));
    return;
end

[handles.MatrixCarcteristicaEntrenar handles.MatrixCarcteristicaObjetivos] ...
     = Obtener_Matrix_Caractersitica_Entrenar_Objetivos(handles, hObject);

guidata(hObject, handles);


contador = 1;
if (valor_caracteristica1 == 1)
    ARFF.Gray.kind = 'Numeric';
    ARFF.Gray.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;
end

if (valor_caracteristica2 == 1)
    ARFF.Hue.kind = 'Numeric';
    ARFF.Hue.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;
end

if (valor_caracteristica3 == 1)
    ARFF.Sat.kind = 'Numeric';
    ARFF.Sat.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica4 == 1)
    ARFF.Bright.kind = 'Numeric';
    ARFF.Bright.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica5 == 1)
    ARFF.Y.kind = 'Numeric';
    ARFF.Y.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica6 == 1)
    ARFF.CB.kind = 'Numeric';
    ARFF.CB.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica7 == 1)
    ARFF.CR.kind = 'Numeric';
    ARFF.CR.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica8 == 1)
    ARFF.RadioRGB.kind = 'Numeric';
    ARFF.RadioRGB.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end
if (valor_caracteristica9 == 1)
    ARFF.HessianModule.kind = 'Numeric';
    ARFF.HessianModule.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;
end

if (valor_caracteristica10 == 1)
    ARFF.HessianTrace.kind = 'Numeric';
    ARFF.HessianTrace.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;
end

if (valor_caracteristica11 == 1)
    ARFF.HessianDeterminant.kind = 'Numeric';
    ARFF.HessianDeterminant.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica12 == 1)
    ARFF.HessianFirstEigenvalue.kind = 'Numeric';
    ARFF.HessianFirstEigenvalue.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica13 == 1)
    ARFF.HessianSecondEigenvalue.kind = 'Numeric';
    ARFF.HessianSecondEigenvalue.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica14 == 1)
    ARFF.HessianOrientation.kind = 'Numeric';
    ARFF.HessianOrientation.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica15 == 1)
    ARFF.BilateralFilterHue.kind = 'Numeric';
    ARFF.BilateralFilterHue.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica16 == 1)
    ARFF.Median.kind = 'Numeric';
    ARFF.Median.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

numero_clases = length(handles.Vector_Masks);

ARFF.Class.kind = 'String';
for k =1: size(handles.MatrixCarcteristicaObjetivos, 2)
    class = sprintf('class %d', vec2ind(handles.MatrixCarcteristicaObjetivos(:,k)));
    if k == 1
       ARFF.Class.values = [{class}];
    else
       ARFF.Class.values = [ARFF.Class.values {class}];
    end
end

[file,path] = uiputfile('*.arff','Save file name');
ruta = strcat(path, file(1:length(file)-5));
if isempty(ruta)
    disp('You did not Export File.');
else 
    arffparser('write', ruta, ARFF, 'segment', 'Diego F.', numero_clases);
    disp('Guardado!');
end
%%%%%%%%%%%%%


% --- Executes on button press in Boton_Train_Weka.
function Boton_Train_Weka_Callback(hObject, eventdata, handles)
% hObject    handle to Boton_Train_Weka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor_caracteristica1 = get(handles.Caracteristica1, 'Value');
valor_caracteristica2 = get(handles.Caracteristica2, 'Value');
valor_caracteristica3 = get(handles.Caracteristica3, 'Value');
valor_caracteristica4 = get(handles.Caracteristica4, 'Value');
valor_caracteristica5 = get(handles.Caracteristica5, 'Value');
valor_caracteristica6 = get(handles.Caracteristica6, 'Value');
valor_caracteristica7 = get(handles.Caracteristica7, 'Value');
valor_caracteristica8 = get(handles.Caracteristica8, 'Value');

valor_caracteristica9 = get(handles.Caracteristica9, 'Value');
valor_caracteristica10 = get(handles.Caracteristica10, 'Value');
valor_caracteristica11 = get(handles.Caracteristica11, 'Value');
valor_caracteristica12 = get(handles.Caracteristica12, 'Value');
valor_caracteristica13 = get(handles.Caracteristica13, 'Value');
valor_caracteristica14 = get(handles.Caracteristica14, 'Value');
valor_caracteristica15 = get(handles.Caracteristica15, 'Value');
valor_caracteristica16 = get(handles.Caracteristica16, 'Value');

vector_valores_caracteristicas = [valor_caracteristica1 valor_caracteristica2 ...
                                  valor_caracteristica3 valor_caracteristica4 ...
                                  valor_caracteristica5 valor_caracteristica6 ...
                                  valor_caracteristica7 valor_caracteristica8 ...
                                  valor_caracteristica9 valor_caracteristica10 ...
                                  valor_caracteristica11 valor_caracteristica12 ...
                                  valor_caracteristica13 valor_caracteristica14 ...
                                  valor_caracteristica15 valor_caracteristica16];

if (length(find(vector_valores_caracteristicas)) < 2 )
    uiwait(errordlg('El número de características debe ser mayor que 1','Número de Características'));
    return;
end

[handles.MatrixCarcteristicaEntrenar handles.MatrixCarcteristicaObjetivos] ...
     = Obtener_Matrix_Caractersitica_Entrenar_Objetivos(handles, hObject);

guidata(hObject, handles);


contador = 1;
if (valor_caracteristica1 == 1)
    ARFF.Gray.kind = 'Numeric';
    ARFF.Gray.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;
end

if (valor_caracteristica2 == 1)
    ARFF.Hue.kind = 'Numeric';
    ARFF.Hue.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;
end

if (valor_caracteristica3 == 1)
    ARFF.Sat.kind = 'Numeric';
    ARFF.Sat.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica4 == 1)
    ARFF.Bright.kind = 'Numeric';
    ARFF.Bright.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica5 == 1)
    ARFF.Y.kind = 'Numeric';
    ARFF.Y.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica6 == 1)
    ARFF.CB.kind = 'Numeric';
    ARFF.CB.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica7 == 1)
    ARFF.CR.kind = 'Numeric';
    ARFF.CR.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica8 == 1)
    ARFF.RadioRGB.kind = 'Numeric';
    ARFF.RadioRGB.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end
if (valor_caracteristica9 == 1)
    ARFF.HessianModule.kind = 'Numeric';
    ARFF.HessianModule.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;
end

if (valor_caracteristica10 == 1)
    ARFF.HessianTrace.kind = 'Numeric';
    ARFF.HessianTrace.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;
end

if (valor_caracteristica11 == 1)
    ARFF.HessianDeterminant.kind = 'Numeric';
    ARFF.HessianDeterminant.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica12 == 1)
    ARFF.HessianFirstEigenvalue.kind = 'Numeric';
    ARFF.HessianFirstEigenvalue.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica13 == 1)
    ARFF.HessianSecondEigenvalue.kind = 'Numeric';
    ARFF.HessianSecondEigenvalue.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica14 == 1)
    ARFF.HessianOrientation.kind = 'Numeric';
    ARFF.HessianOrientation.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica15 == 1)
    ARFF.BilateralFilterHue.kind = 'Numeric';
    ARFF.BilateralFilterHue.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

if (valor_caracteristica16 == 1)
    ARFF.Median.kind = 'Numeric';
    ARFF.Median.values = handles.MatrixCarcteristicaEntrenar(contador, :);
    contador = contador + 1;    
end

numero_clases = length(handles.Vector_Masks);

ARFF.Class.kind = 'String';
for k =1: size(handles.MatrixCarcteristicaObjetivos, 2)
    class = sprintf('class %d', vec2ind(handles.MatrixCarcteristicaObjetivos(:,k)));
    if k == 1
       ARFF.Class.values = [{class}];
    else
       ARFF.Class.values = [ARFF.Class.values {class}];
    end
end

arffparser('write', 'DataSet_Pattern_Pixel_Segmentation', ARFF, 'segment', 'Diego F.', numero_clases);
disp('Dataset guardado!')

system('"C:\\Program Files\\Java\\jre7\\bin\\java" weka.classifiers.trees.RandomForest -t DataSet_Pattern_Pixel_Segmentation.arff -d ModeloRadomForest.model');
disp('Modelo guardado!');

%%%%%%%%%%%%%


% --- Executes on button press in Boton_Segment_Weka.
function Boton_Segment_Weka_Callback(hObject, eventdata, handles)
% hObject    handle to Boton_Segment_Weka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor_caracteristica1 = get(handles.Caracteristica1, 'Value');
valor_caracteristica2 = get(handles.Caracteristica2, 'Value');
valor_caracteristica3 = get(handles.Caracteristica3, 'Value');
valor_caracteristica4 = get(handles.Caracteristica4, 'Value');
valor_caracteristica5 = get(handles.Caracteristica5, 'Value');
valor_caracteristica6 = get(handles.Caracteristica6, 'Value');
valor_caracteristica7 = get(handles.Caracteristica7, 'Value');
valor_caracteristica8 = get(handles.Caracteristica8, 'Value');

valor_caracteristica9 = get(handles.Caracteristica9, 'Value');
valor_caracteristica10 = get(handles.Caracteristica10, 'Value');
valor_caracteristica11 = get(handles.Caracteristica11, 'Value');
valor_caracteristica12 = get(handles.Caracteristica12, 'Value');
valor_caracteristica13 = get(handles.Caracteristica13, 'Value');
valor_caracteristica14 = get(handles.Caracteristica14, 'Value');
valor_caracteristica15 = get(handles.Caracteristica15, 'Value');
valor_caracteristica16 = get(handles.Caracteristica16, 'Value');

vector_valores_caracteristicas = [valor_caracteristica1 valor_caracteristica2 ...
                                  valor_caracteristica3 valor_caracteristica4 ...
                                  valor_caracteristica5 valor_caracteristica6 ...
                                  valor_caracteristica7 valor_caracteristica8 ...
                                  valor_caracteristica9 valor_caracteristica10 ...
                                  valor_caracteristica11 valor_caracteristica12 ...
                                  valor_caracteristica13 valor_caracteristica14 ...
                                  valor_caracteristica15 valor_caracteristica16];

if (length(find(vector_valores_caracteristicas)) < 2 )
    uiwait(errordlg('El número de características debe ser mayor que 1','Número de Características'));
    return;
end

[handles.MatrixCarcteristicaEntrenar handles.MatrixCarcteristicaObjetivos] ...
     = Obtener_Matrix_Caractersitica_Entrenar_Objetivos(handles, hObject);

guidata(hObject, handles);

tic;
contador = 1;
if (valor_caracteristica1 == 1)
    ARFF.Gray.kind = 'Numeric';
    ARFF.Gray.values = Fila_Carcateristica1_Test_Segmentar(handles, hObject);
    contador = contador + 1;
end

if (valor_caracteristica2 == 1)
    ARFF.Hue.kind = 'Numeric';
    ARFF.Hue.values = Fila_Carcateristica2_Test_Segmentar(handles, hObject);
    contador = contador + 1;
end

if (valor_caracteristica3 == 1)
    ARFF.Sat.kind = 'Numeric';
    ARFF.Sat.values = Fila_Carcateristica3_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica4 == 1)
    ARFF.Bright.kind = 'Numeric';
    ARFF.Bright.values = Fila_Carcateristica4_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica5 == 1)
    ARFF.Y.kind = 'Numeric';
    ARFF.Y.values = Fila_Carcateristica5_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica6 == 1)
    ARFF.CB.kind = 'Numeric';
    ARFF.CB.values = Fila_Carcateristica6_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica7 == 1)
    ARFF.CR.kind = 'Numeric';
    ARFF.CR.values = Fila_Carcateristica7_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica8 == 1)
    ARFF.RadioRGB.kind = 'Numeric';
    ARFF.RadioRGB.values = Fila_Carcateristica8_Test_Segmentar(handles, hObject);
    contador = contador + 1;
end

if (valor_caracteristica9 == 1)
    ARFF.HessianModule.kind = 'Numeric';
    ARFF.HessianModule.values = Fila_Carcateristica9_Test_Segmentar(handles, hObject);
    contador = contador + 1;
end

if (valor_caracteristica10 == 1)
    ARFF.HessianTrace.kind = 'Numeric';
    ARFF.HessianTrace.values = Fila_Carcateristica10_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica11 == 1)
    ARFF.HessianDeterminant.kind = 'Numeric';
    ARFF.HessianDeterminant.values = Fila_Carcateristica11_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica12 == 1)
    ARFF.HessianFirstEigenvalue.kind = 'Numeric';
    ARFF.HessianFirstEigenvalue.values = Fila_Carcateristica12_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica13 == 1)
    ARFF.HessianSecondEigenvalue.kind = 'Numeric';
    ARFF.HessianSecondEigenvalue.values = Fila_Carcateristica13_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica14 == 1)
    ARFF.HessianOrientation.kind = 'Numeric';
    ARFF.HessianOrientation.values = Fila_Carcateristica14_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica15 == 1)
    ARFF.BilateralFilterHue.kind = 'Numeric';
    ARFF.BilateralFilterHue.values = Fila_Carcateristica15_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica16 == 1)
    ARFF.Median.kind = 'Numeric';
    ARFF.Median.values = Fila_Carcateristica16_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

numero_clases = length(handles.Vector_Masks);
[Alto Ancho Canales] = size(handles.Image_Input);
ARFF.Class.kind = 'String';
for k =1:Alto*Ancho
    class = sprintf('class %d', round((1 + (numero_clases -1)*rand())));
    if k == 1
       ARFF.Class.values = [{class}];
    else
       ARFF.Class.values = [ARFF.Class.values {class}];
    end
end

arffparser('write', 'DataSetTest_Pattern_Pixel_Segmentation', ARFF, 'segment', 'Diego F.', numero_clases);
toc
disp('Dataset Test Guardado');
tic;
system('"C:\\Program Files\\Java\\jre7\\bin\\java" weka.filters.supervised.attribute.AddClassification -serialized ModeloRadomForest.model -classification -i DataSetTest_Pattern_Pixel_Segmentation.arff -o DataSetPred_Pattern_Pixel_Segmentation.arff -c last');
toc;
disp('Predicciones listas!');
Predicciones = arffparser('read', 'DataSetPred_Pattern_Pixel_Segmentation');

tic;
Imagen_Segmentacion = zeros(Alto, Ancho);
for i=1:Alto
    for j=1:Ancho
        class = Predicciones.classification.values{j+((i-1)*Ancho)};
        Imagen_Segmentacion(i,j) = str2num(class(6));
    end
end
Imagen_Segmentacion_Label = label2rgb(Imagen_Segmentacion);
toc;
disp('Segmentación lista!')
set(handles.Edit_Input_Num_Clases, 'String', num2str(numero_clases));
axes(handles.Ejes_Segmentar_Weka);
imshow(Imagen_Segmentacion_Label);
handles.ImageSegWeka = Imagen_Segmentacion_Label;
guidata(hObject, handles);


function [Fila_Test] = Fila_Carcateristica1_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica1_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica2_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica2_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica3_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica3_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica4_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica4_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica5_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica5_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica6_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica6_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica7_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica7_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica8_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica8_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica9_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica9_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica10_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica10_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica11_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica11_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica12_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica12_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica13_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica13_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica14_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica14_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica15_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica15_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

function [Fila_Test] = Fila_Carcateristica16_Test_Segmentar(handles, hObject)
[Alto Ancho Canales] = size(handles.Image_Input);
Fila = zeros(1,Alto*Ancho);
for i=1:Alto
    for j=1:Ancho
        Fila(j + ((i-1)*Ancho)) = Obtener_Caracteristica16_Pixel_XY(handles, hObject, i, j);
    end
end
Fila_Test = Fila;

% --- Executes on selection change in Menu_Resize.
function Menu_Resize_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Resize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opcion_resize = get(handles.Menu_Resize, 'Value');
handles.FactorResize=1;
switch opcion_resize
    case 1
        handles.FactorResize=1;
    case 2
        handles.FactorResize=0.9;
    case 3
        handles.FactorResize=0.8;
    case 4
        handles.FactorResize=0.7;
    case 5
        handles.FactorResize=0.6;
    case 6
        handles.FactorResize=0.5;
    case 7
        handles.FactorResize=0.4;
    case 8
        handles.FactorResize=0.3;
    case 9
        handles.FactorResize=0.2;
    otherwise
        handles.FactorResize=0.1;
end

Imagen_Entrada = imresize(handles.Image_Original, handles.FactorResize);
handles.Image_Input = Imagen_Entrada;
axes(handles.Ejes_Imagen_Entrada);
imshow(Imagen_Entrada);
guidata(hObject, handles);
set(handles.Edit_W, 'String', num2str(size(handles.Image_Input,2)));
set(handles.Edit_H, 'String', num2str(size(handles.Image_Input,1)));
set(handles.Edit_Total_Pixel, 'String', num2str((size(handles.Image_Input,2))*(size(handles.Image_Input,1))));
% Hints: contents = cellstr(get(hObject,'String')) returns Menu_Resize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Menu_Resize


% --- Executes during object creation, after setting all properties.
function Menu_Resize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Menu_Resize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_W_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_W as text
%        str2double(get(hObject,'String')) returns contents of Edit_W as a double


% --- Executes during object creation, after setting all properties.
function Edit_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_H_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_H as text
%        str2double(get(hObject,'String')) returns contents of Edit_H as a double


% --- Executes during object creation, after setting all properties.
function Edit_H_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Total_Pixel_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Total_Pixel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Total_Pixel as text
%        str2double(get(hObject,'String')) returns contents of Edit_Total_Pixel as a double


% --- Executes during object creation, after setting all properties.
function Edit_Total_Pixel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Total_Pixel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Acumulado_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Acumulado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Acumulado as text
%        str2double(get(hObject,'String')) returns contents of Edit_Acumulado as a double


% --- Executes during object creation, after setting all properties.
function Edit_Acumulado_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Acumulado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Boton_Apply_Model.
function Boton_Apply_Model_Callback(hObject, eventdata, handles)
% hObject    handle to Boton_Apply_Model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor_caracteristica1 = get(handles.Caracteristica1, 'Value');
valor_caracteristica2 = get(handles.Caracteristica2, 'Value');
valor_caracteristica3 = get(handles.Caracteristica3, 'Value');
valor_caracteristica4 = get(handles.Caracteristica4, 'Value');
valor_caracteristica5 = get(handles.Caracteristica5, 'Value');
valor_caracteristica6 = get(handles.Caracteristica6, 'Value');
valor_caracteristica7 = get(handles.Caracteristica7, 'Value');
valor_caracteristica8 = get(handles.Caracteristica8, 'Value');

valor_caracteristica9 = get(handles.Caracteristica9, 'Value');
valor_caracteristica10 = get(handles.Caracteristica10, 'Value');
valor_caracteristica11 = get(handles.Caracteristica11, 'Value');
valor_caracteristica12 = get(handles.Caracteristica12, 'Value');
valor_caracteristica13 = get(handles.Caracteristica13, 'Value');
valor_caracteristica14 = get(handles.Caracteristica14, 'Value');
valor_caracteristica15 = get(handles.Caracteristica15, 'Value');
valor_caracteristica16 = get(handles.Caracteristica16, 'Value');

vector_valores_caracteristicas = [valor_caracteristica1 valor_caracteristica2 ...
                                  valor_caracteristica3 valor_caracteristica4 ...
                                  valor_caracteristica5 valor_caracteristica6 ...
                                  valor_caracteristica7 valor_caracteristica8 ...
                                  valor_caracteristica9 valor_caracteristica10 ...
                                  valor_caracteristica11 valor_caracteristica12 ...
                                  valor_caracteristica13 valor_caracteristica14 ...
                                  valor_caracteristica15 valor_caracteristica16];

if (length(find(vector_valores_caracteristicas)) < 2 )
    uiwait(errordlg('El número de características debe ser mayor que 1','Número de Características'));
    return;
end

[handles.MatrixCarcteristicaEntrenar handles.MatrixCarcteristicaObjetivos] ...
     = Obtener_Matrix_Caractersitica_Entrenar_Objetivos(handles, hObject);

guidata(hObject, handles);

tic;
contador = 1;
if (valor_caracteristica1 == 1)
    ARFF.Gray.kind = 'Numeric';
    ARFF.Gray.values = Fila_Carcateristica1_Test_Segmentar(handles, hObject);
    contador = contador + 1;
end

if (valor_caracteristica2 == 1)
    ARFF.Hue.kind = 'Numeric';
    ARFF.Hue.values = Fila_Carcateristica2_Test_Segmentar(handles, hObject);
    contador = contador + 1;
end

if (valor_caracteristica3 == 1)
    ARFF.Sat.kind = 'Numeric';
    ARFF.Sat.values = Fila_Carcateristica3_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica4 == 1)
    ARFF.Bright.kind = 'Numeric';
    ARFF.Bright.values = Fila_Carcateristica4_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica5 == 1)
    ARFF.Y.kind = 'Numeric';
    ARFF.Y.values = Fila_Carcateristica5_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica6 == 1)
    ARFF.CB.kind = 'Numeric';
    ARFF.CB.values = Fila_Carcateristica6_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica7 == 1)
    ARFF.CR.kind = 'Numeric';
    ARFF.CR.values = Fila_Carcateristica7_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica8 == 1)
    ARFF.RadioRGB.kind = 'Numeric';
    ARFF.RadioRGB.values = Fila_Carcateristica8_Test_Segmentar(handles, hObject);
    contador = contador + 1;
end

if (valor_caracteristica9 == 1)
    ARFF.HessianModule.kind = 'Numeric';
    ARFF.HessianModule.values = Fila_Carcateristica9_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica10 == 1)
    ARFF.HessianTrace.kind = 'Numeric';
    ARFF.HessianTrace.values = Fila_Carcateristica10_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica11 == 1)
    ARFF.HessianDeterminant.kind = 'Numeric';
    ARFF.HessianDeterminant.values = Fila_Carcateristica11_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica12 == 1)
    ARFF.HessianFirstEigenvalue.kind = 'Numeric';
    ARFF.HessianFirstEigenvalue.values = Fila_Carcateristica12_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica13 == 1)
    ARFF.HessianSecondEigenvalue.kind = 'Numeric';
    ARFF.HessianSecondEigenvalue.values = Fila_Carcateristica13_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica14 == 1)
    ARFF.HessianOrientation.kind = 'Numeric';
    ARFF.HessianOrientation.values = Fila_Carcateristica14_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica15 == 1)
    ARFF.BilateralFilterHue.kind = 'Numeric';
    ARFF.BilateralFilterHue.values = Fila_Carcateristica15_Test_Segmentar(handles, hObject);
    contador = contador + 1;    
end

if (valor_caracteristica16 == 1)
    ARFF.Median.kind = 'Numeric';
    ARFF.Median.values = Fila_Carcateristica16_Test_Segmentar(handles, hObject);
    contador = contador + 1;
end

numero_clases = str2num(get(handles.Edit_Input_Num_Clases, 'String'));
[Alto Ancho Canales] = size(handles.Image_Input);
ARFF.Class.kind = 'String';
for k =1:Alto*Ancho
    class = sprintf('class %d', round((1 + (numero_clases -1)*rand())));
    if k == 1
       ARFF.Class.values = [{class}];
    else
       ARFF.Class.values = [ARFF.Class.values {class}];
    end
end

arffparser('write', 'DataSetTest_Pattern_Pixel_Segmentation', ARFF, 'segment', 'Diego F.', numero_clases);
toc
disp('Dataset Test Guardado');
tic;
[file path] = uigetfile('*.model', 'Seleccionar Modelo');
ruta = strcat(' "', path, file, '"');
command = strcat('"C:\\Program Files\\Java\\jre7\\bin\\java" weka.filters.supervised.attribute.AddClassification -serialized' ,ruta, ' -classification -i DataSetTest_Pattern_Pixel_Segmentation.arff -o DataSetPred_Pattern_Pixel_Segmentation.arff -c last')
system(command);
toc;
disp('Predicciones listas!');
Predicciones = arffparser('read', 'DataSetPred_Pattern_Pixel_Segmentation');

tic;
Imagen_Segmentacion = zeros(Alto, Ancho);
for i=1:Alto
    for j=1:Ancho
        class = Predicciones.classification.values{j+((i-1)*Ancho)};
        Imagen_Segmentacion(i,j) = str2num(class(6));
    end
end
Imagen_Segmentacion_Label = label2rgb(Imagen_Segmentacion);
toc;
disp('Segmentación lista!')
axes(handles.Ejes_Segmentar_Weka);
imshow(Imagen_Segmentacion_Label);
handles.ImageSegWeka = Imagen_Segmentacion_Label;
guidata(hObject, handles);


function Edit_Input_Num_Clases_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Input_Num_Clases (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Input_Num_Clases as text
%        str2double(get(hObject,'String')) returns contents of Edit_Input_Num_Clases as a double


% --- Executes during object creation, after setting all properties.
function Edit_Input_Num_Clases_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Input_Num_Clases (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Boton_SaveIMat.
function Boton_SaveIMat_Callback(hObject, eventdata, handles)
% hObject    handle to Boton_SaveIMat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (isfield(handles, 'ImageSegMatlab'))
    [file path] = uiputfile({'*.jpg';'*.png';'*.bmp';'*.*'}, 'Save Image Segmented');
    ruta = strcat(path, file);
    if isempty(ruta)
        disp('You did not save Image');
    else
        imwrite(handles.ImageSegMatlab,ruta,'png');
    end
else
    disp('No Image to save.');
end

% --- Executes on button press in Edit_SaveIWeka.
function Edit_SaveIWeka_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_SaveIWeka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (isfield(handles, 'ImageSegWeka'))
    [file path] = uiputfile({'*.jpg';'*.png';'*.bmp';'*.*'}, 'Save Image Segmented');
    ruta = strcat(path, file);
    if isempty(ruta)
        disp('You did not save Image');
    else 
        imwrite(handles.ImageSegWeka,ruta,'png');
    end
else
    disp('No Image to save.');
end


% --- Executes on button press in Boton_Eval.
function Boton_Eval_Callback(hObject, eventdata, handles)
% hObject    handle to Boton_Eval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (isfield(handles, 'ImageSegMatlab') == 1) && (isfield(handles, 'ImageSegWeka') == 1)
    if size(handles.ImageSegMatlab) == size(handles.ImageSegWeka)
        
        imwrite(handles.ImageSegMatlab, 'Temp1.png', 'png');
        imwrite(handles.ImageSegWeka, 'Temp2.png', 'png');
        command = strcat(handles.OfeliPath, ' Temp1.png', ' Temp2.png');
        system(command);
    else
        system(handles.OfeliPath);
    end
else
    system(handles.OfeliPath);
end


% --- Executes on button press in Checkbox_Paralela.
function Checkbox_Paralela_Callback(hObject, eventdata, handles)
% hObject    handle to Checkbox_Paralela (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Checkbox_Paralela


% --- Executes on button press in Checkbox_Image_Caractersitica.
function Checkbox_Image_Caractersitica_Callback(hObject, eventdata, handles)
% hObject    handle to Checkbox_Image_Caractersitica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Checkbox_Image_Caractersitica


% --- Executes during object creation, after setting all properties.
function Boton_Cargar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Boton_Cargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('\Images_Icons\open.png', 'png'), 1.15));


% --- Executes during object creation, after setting all properties.
function Export_ARFF_Boton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Export_ARFF_Boton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('\Images_Icons\ExportARFF.png', 'png'), 0.25));


% --- Executes during object creation, after setting all properties.
function Ver_Feature_Space_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ver_Feature_Space (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('\Images_Icons\3DCoordinate.png', 'png'), 0.39));


% --- Executes during object creation, after setting all properties.
function Boton_Weka_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Boton_Weka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('\Images_Icons\WekaIcon.png', 'png'), 0.7));


% --- Executes during object creation, after setting all properties.
function Boton_Eval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Boton_Eval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('\Images_Icons\EvaluateSegmentation.png', 'png'), 0.5));


% --- Executes during object creation, after setting all properties.
function Boton_Anadir_Clase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Boton_Anadir_Clase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('\Images_Icons\AddIcon.png', 'png'), 0.35));


% --- Executes during object creation, after setting all properties.
function Boton_Borrar_Clase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Boton_Borrar_Clase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('\Images_Icons\EraseIcon.png', 'png'), 0.35));


% --- Executes during object creation, after setting all properties.
function Boton_SaveIMat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Boton_SaveIMat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('\Images_Icons\saveasimage.png', 'png'), 0.9));


% --- Executes during object creation, after setting all properties.
function Edit_SaveIWeka_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_SaveIWeka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('\Images_Icons\saveasimage.png', 'png'), 0.9));
