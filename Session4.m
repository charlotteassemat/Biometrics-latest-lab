close all
clear all
clc
video_names={'Sequence1'};

% Session 4
tic
display('entering test template')
%Test_Templates
display('exiting test template')
display('entering silhouette detector')
test_Silhouette_detector
display('entering read silhouette blobs')
test_ReadSilhouetteBlobs
toc