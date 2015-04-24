% clear all
% close all
% clc

video_dir='./Videos';
threshold=0;
threshold=-1.5;

video_dir='./Videos';
video_names={'tud-campus-sequence'};


for i=1:size(video_names,2)
    video_list=sprintf('%s/%s/%slist.txt',video_dir,video_names{i},video_names{i});
    fid=fopen(video_list,'r');
    num_images=0;
    cadena=fgets(fid);
    images_names={};
    while(size(cadena,2)>4)
        num_images=num_images+1;
        index=find((cadena==' ' | cadena==char(13))==1);
        if(~isempty(index))
            images_names{num_images}=cadena(1:index(1)-1);
        else
            images_names{num_images}=cadena;
        end
        cadena=fgets(fid);

    end
    fclose(fid);
    DTDP_detector(images_names,threshold,video_names{i},video_dir);     
end


