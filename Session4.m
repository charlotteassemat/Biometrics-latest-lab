close all
clear all
clc

video_names={'Sequence1'};

% Session 4
tic
display('entering extract+process templates')
Extract_Templates
Process_Templates
display('entering test template')
Test_Templates
display('entering silhouette detector')
test_Silhouette_detector
display('entering read silhouette blobs')
test_ReadSilhouetteBlobs
toc