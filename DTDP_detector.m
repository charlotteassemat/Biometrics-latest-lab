
function DTDP_detector(images_names,threshold,video,video_dir,sbin)

addpath('./DTDP detector/voc-release4.01_windows32bit');
load('./DTDP detector/voc-release4.01_windows32bit/INRIA/inriaperson_final.mat');

if nargin > 4
    model.sbin=sbin;
end
 

for i=1:size(images_names,2)
    cadena=sprintf('%s/%s/%s',video_dir,video,images_names{i});  
    test(cadena, model,images_names{i},threshold,video,video_dir,i);    
end
clear model




function test(name, model,image_name,threshold,video,video_dir,num_frame)

im = imread(name);

% detect objects
[dets, boxes] = imgdetect(im, model, threshold);


overlap=0.5;
top = nms(dets, overlap);
% get bounding boxes
if(~isempty(top))  
    bbox = bboxpred_get(model.bboxpred, dets, reduceboxes(model, boxes));
    bbox = clipboxes(im, bbox);
    top = nms(bbox, overlap);
    final_blobs=bbox(top,:);
else
    final_blobs=[];
end
out_filename=sprintf('%s/%s/%s_dtdp_%.2f.idl',video_dir,video,video,threshold);
if(num_frame==1)
    fid=fopen(out_filename,'w+');
    fclose(fid);
end
display('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA')
save_blobs(final_blobs,name,out_filename);
clear top clear bbox
clear final_blobs

    

