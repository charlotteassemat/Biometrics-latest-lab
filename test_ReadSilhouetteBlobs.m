%clear all
close all
%clc

video_dir='./Videos';
thr=0.1;
threshold=0.6;
overlap = 0.5;

video_dir='./Videos';
%video_names={'Sequence2'};

for i=1:size(video_names,2)
    filename_Silhouette=sprintf('%s/%s/%s_Silhouette_%.2f.idl',video_dir,video_names{i},video_names{i},thr);
    video_list=sprintf('%s/%s/images/%slist.txt',video_dir,video_names{i},video_names{i});
    fid=fopen(video_list,'r');
    num_images=0;
    cadena=fgets(fid);
    while(size(cadena,2)>4)
        num_images=num_images+1;
        cadena=fgets(fid);
    end
    num_images=num_images-1;
    fclose(fid);
    
    [Blobs]=ReadSilhouetteBlobs(filename_Silhouette,video_names{i});
    Blobs=Blobs_Threshold(Blobs,threshold);
    size(Blobs)
    %Blobs = nonMaxSupp(Blobs,overlap);
    for frame=1:1:num_images
        cadena=sprintf('%s/%s/images/frame%.4d.png',video_dir,video_names{i},frame); 
        imagen=imread(cadena);
        if(size(Blobs,2)>=frame)
            imagen=PaintBlobs(Blobs{frame},imagen,[0 255 0]);
        end
        imshow(imagen)
        %waitforbuttonpress;
        cadena=sprintf('%s/%s/images/frame%.4d_out.png',video_dir,video_names{i},frame); 
        imwrite(imagen,cadena);
        pause(0.01);
    end

end