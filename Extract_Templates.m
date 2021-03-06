
%Opens 4 sequences of images and the associated masks, it will save the templates in the
%Templates_train directory
%Masks know which are the moving people and the moving objects.
%Templates_train directory at the end of the projects should only contains
%the masks of the people without any objects.
%original version : only rewrite the mask.

video_dir='./Videos';
templates_directory='./Templates_train';
mkdir Templates_train;

num_templates=0;
for i=1:size(video_names,2)    
    dir=sprintf('cd ''%s''',pwd);
    directory_masks=sprintf('cd %s/%s/masks/',video_dir,video_names{i})  ;  
    eval(directory_masks);
    
    % --- for linux
    [sts,number_masks] = system('ls -1 | wc -l');
    number_masks_test = str2num(number_masks);
    % --- for windows
    
    eval(dir);
    
    for j=3:str2num(number_masks)   
       
        name_mask=sprintf('%s/%s/masks/frame%.4d.png',video_dir,video_names{i},j-3);
        
        %read the mask associated to each frame
        mask=imread(name_mask);
        CC = bwconncomp(mask);  
        numPixels = cellfun(@numel,CC.PixelIdxList);
        [biggest,idx] = max(numPixels);
        S = regionprops(CC,'BoundingBox');
        y1 = round(S(idx,1).BoundingBox(1,1));
        x1 = round(S(idx,1).BoundingBox(1,2));
        y2 = round(y1+S(idx,1).BoundingBox(1,3));
        x2 = round(x1+S(idx,1).BoundingBox(1,4));
        
              
        if x1<=0
            x1=1;
        end
        if y1<=0
            y1=1;
        end
        if x2>size(mask,1)
            x2=size(mask,1);
        end
        if y2>size(mask,2)
            y2=size(mask,2);
        end
        crop_image=mask(x1:x2,y1:y2); 
        num_templates=num_templates+1;
        template_name=sprintf('%s/template%.4d.png',templates_directory,num_templates);
        imwrite(crop_image,template_name)
    end        
end