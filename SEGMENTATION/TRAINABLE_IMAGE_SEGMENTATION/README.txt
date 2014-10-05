TRAINABLE IMAGE SEGEMENTATION

This utility allows you to segment image via pixel classification. You can use 
default Matlab's classifiers or Weka advanced classifiers.

//////////////////////////////////////////////////////////////////////////////

Before Ruuning.

You must install:
1 - Java Development Kit (JDK. Download from: http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html

2 - Tesseract OCR - Donwload from: https://code.google.com/p/tesseract-ocr/downloads/list
    Tesseract allows you to automatically extract range temperature information from IR
    Image, acquired from example from FLIR Image.

3 - Weka (Data Mining) - Download from: http://www.cs.waikato.ac.nz/ml/weka/downloading.html
    This software allows you to train and apply classifier for pixel image based classification.

4 - If you are on Windows extract "OFELI.exe" (for Segmentation Comparison using Haussdorff Distance)
    (and DLL's) from "OFELI_WINDOWS_EXECUTABLE.rar" which is inside "RESOURCES"  directory. 
    For other platforms extract sources from "OFELI_SOURCE.rar" and compile using QtCreator (load ofeli.pro), 
    or configure via CMake and build with your prefered IDE; Qt and Boost libraries are needed. Look for on 
    internet how to install these libraries for your platform.
 
5 - Optionally you can download Java3d for Weka 3D visualization of Feature Space.
    Download from: https://java3d.java.net/binary-builds.html

/////////////////////////////////////////////////////////////////////////////////////
Copy PATH to config file:

Once installed copy Tesseract and Weka binary executable PATH to config file
in order to adequately running TRAINABLE_IMAGE_SEGMENTATION.m. For Example in 
my case: 

1 - Weka (Data Mining):       
    Path: D:\\LIBRERIAS\\Weka-3-7\\Weka 3.7.lnk

2 - Tesseract (Optical Character Recognition):  
    Path: D:\\LIBRERIAS\\Tesseract-OCR\\tesseract

3 - OFELI: (Image Segmentation Comparisson using Haussdorff Distance)
    Path: RESOURCES\\OFELI