close all
video_dir='./Videos';
templates_directory='Templates_test';

dir=sprintf('cd ''%s''',pwd);
templates_dir=sprintf('cd %s/',templates_directory);
eval(templates_dir);

% --- for windows:
%number_t=ls;
%number_templates = size(number_t,1) ;
% --- for linux:
[sts,number_t] = system('ls -1 | wc -l'); 
number_templates = str2num(number_t);

eval (dir);
confidence_table(1,:) = [-1,-1,-1,-1,-1,-1]; % -1 is only for initialization purposes.

for i=1:size(video_names,2)    
    dir=sprintf('cd ''%s''',pwd);
    directory_masks=sprintf('cd %s/%s/masks/',video_dir,video_names{i});
    eval(directory_masks);
    % --- for linux:
    [sts,number_masks_test] = system('ls -1 | wc -l'); 
    number_masks_test = str2num(number_masks_test);
    % --- for windows:
    %number_masks_t=ls;    
    %number_masks_test = size(number_masks_t,1);
    
    eval (dir) 
    cfidx = 1;
    for j=3:number_masks_test-1  %go through the masks of the new video, they have to be tested.            
        name_mask=sprintf('%s/%s/masks/frame%.4d.png',video_dir,video_names{i},j-3);
        mask_test=imread(name_mask);

        for k=3:number_templates-2   %go through the templates chosen in the last lab. Will be used to test the new masks.
            name_mask=sprintf('%s/template%.4d.png',templates_directory,k-2);
            mask_template=imread(name_mask);
            
            %make correlation between template/new input
            [xymax, smax] = correlation_filter2(mask_template,mask_test);
                     
            %remembering the frame number
            xymaxL = length(xymax);
            framenb = (j-2)*ones(xymaxL,1) ;
           
            %compute x and y indices according to smax this is the center
            %coordinates of the blob
            [yind,xind] = ind2sub(size(mask_test),smax);
           
            %compute height and width of the template
            [ht,wt] = size(mask_template);            
            hta = ht*ones(xymaxL,1);
            wta = wt*ones(xymaxL,1);
            %find the upper left corner coordinates
            ux = xind - floor(wt/2);
            uy = yind - floor(ht/2);
            
            confidence_table(cfidx:cfidx+xymaxL-1,:,:,:,:,:) = [framenb,ux,uy,wta+ux,hta+uy,xymax];
                       
            %update the number of new entries in the table
            cfidx = cfidx + xymaxL-1;
          
        end
    end
    name=strcat('confidence',video_names{i},'.mat');
    save(name,'confidence_table');      
end  
