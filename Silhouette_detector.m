function Silhouette_detector(images_names,threshold,video,video_dir)    
    for i=1:size(images_names,2)
        cadena1=sprintf('%s/%s/images/%s',video_dir,video,images_names{i});  
        cadena2=sprintf('%s/%s/masks/%s',video_dir,video,images_names{i});          
        test(cadena1,cadena2, images_names{i},threshold,video,video_dir,i);    
    end
end


function test(name_image,name_mask, image_name,threshold,video,video_dir,num_frame)

    final_blobs=[];
    %call test_templates script    
    conf = load(strcat('confidence',video,'.mat'));
    confidence_table=conf.confidence_table;
    save  confGHGFH.mat confidence_table;
    final_blobs = confidence_table(find(eq(num_frame,confidence_table(:,1)))',2:end);
    % final_blobs fromat example: Session 1 test_DTDP_Detector
    % final_blobs=[70.4281  158.8926  150.0303  421.8818    1.0296;
    %              210.2631  198.7211  253.6652  347.2814    0.3323;
    %              407.5838  182.9884  477.8997  410.3730   -0.2838;
    %              134.1665  193.4742  194.9127  374.1023   -0.3597;
    %              280.6267  178.8918  346.4894  389.6681   -0.4079;
    %              ....];
    out_filename=sprintf('%s/%s/%s_Silhouette_%.2f.idl',video_dir,video,video,threshold);
    if(num_frame==1)
        fid=fopen(out_filename,'w+');
        fclose(fid);
    end
    save_blobs(final_blobs(1:end,:),name_image,out_filename); %skip the first row and follow the process (first row contains the number of the frame)
end
    

