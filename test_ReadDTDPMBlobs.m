% clear all
% close all
% clc
display('testreaddtdpmblobs')
video_dir='./Videos';
thr=-1.5;
threshold=-0.3;

video_dir='./Videos';
%video_names={'tud-campus-sequence'};

for i=1:size(video_names,2)
    filename_dtdp=sprintf('%s/%s/%s_dtdp_%.2f.idl',video_dir,video_names{i},video_names{i},thr);
    video_list=sprintf('%s/%s/%slist.txt',video_dir,video_names{i},video_names{i});
    fid=fopen(video_list,'r');
    num_images=0;
    cadena=fgets(fid);
    while(size(cadena,2)>4)
        num_images=num_images+1;
        cadena=fgets(fid);
    end
    fclose(fid);
    
    [Blobs]=ReadDTDPMBlobs(filename_dtdp,video_names{i});
    Blobs=Blobs_Threshold(Blobs,threshold);
    for frame=1:1:num_images
        cadena=sprintf('%s/%s/%s-%.3d.png',video_dir,video_names{i},video_names{i},frame); 
        imagen=imread(cadena);
        if(size(Blobs,2)>=frame)
            imagen=PaintBlobs(Blobs{frame},imagen,[0 255 0]);
        end
        imshow(imagen)
        cadena=sprintf('%s/%s/%s-%.3d_out.png',video_dir,video_names{i},video_names{i},frame); 
        imwrite(imagen,cadena)
        pause(0.001);
    end

end