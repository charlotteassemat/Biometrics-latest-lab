function Silhouette_detector(images_names,threshold,video,video_dir)    
    for i=1:size(images_names,2)
        cadena1=sprintf('%s/%s/images/%s',video_dir,video,images_names{i});  
        cadena2=sprintf('%s/%s/masks/%s',video_dir,video,images_names{i});          
        test(cadena1,cadena2, images_names{i},threshold,video,video_dir,i);    
    end
end


function test(name_image,name_mask, image_name,threshold,video,video_dir,num_frame)

    final_blobs=[];
    conf = load(strcat('confidence',video,'.mat'));
    confidence_table=conf.confidence_table;
    save  confGHGFH.mat confidence_table;
    final_blobs = confidence_table(find(eq(num_frame,confidence_table(:,1)))',2:end);
    out_filename=sprintf('%s/%s/%s_Silhouette_%.2f.idl',video_dir,video,video,threshold);
    if(num_frame==1)
        fid=fopen(out_filename,'w+');
        fclose(fid);
    end
    save_blobs(final_blobs(1:end,:),name_image,out_filename);
end
    

