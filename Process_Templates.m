video_dir='./Videos';
templates_directory='Templates_train';
final_templates_directory='./Templates_test';
mkdir Templates_test;

dir=sprintf('cd ''%s''',pwd);
templates_dir=sprintf('cd %s/',templates_directory);
eval(templates_dir);

% --- for windows
%number_masks=ls;

% --- for linux
[sts,number_masks] = system('ls -1 | wc -l'); 
number_masks = str2num(number_masks);
eval (dir);
ratio_values=[];

hash_matrix = zeros(64,number_masks*2);
 
%filling the hash matrix with template + possible additions (upper half..)
%
for j=1:number_masks
    name_mask=sprintf('%s/template%.4d.png',templates_directory,j);
    mask=imread(name_mask);
    
    halfV = floor(size(mask,1)/2);
    hash_matrix(:,j) = HashPic(mask);
    hash_matrix(:,j+1) = HashPic(mask(1:halfV,:));
end
number_masks = number_masks*2; 
index=1:number_masks-2;         
chosen_templates=index(1:1:size(index,2));    

 for k=1:number_masks-1
     for l=k+1:number_masks-1
         X = [hash_matrix(:,k),hash_matrix(:,l)]';
         X = double(X);
         %test if the two images are similar, based on the hamming distance of
         %their hashes.
         if pdist(X,'hamming')*length(X) <=6
                chosen_templates(1,l) = 0;
         end
     end
 end    

%removing all the 0
chosen_templates(chosen_templates == 0) = [];

num_templates=0;
for n=1:size(chosen_templates,2)
    number = floor(chosen_templates(n)/2)+1;
    m = mod(chosen_templates(n),2);
    name_mask=sprintf('%s/template%.4d.png',templates_directory,number);
    mask=imread(name_mask);
    
    if(m==1)
            mask = mask(1:halfV,:);
    end
    num_templates=num_templates+1;
    template_name=sprintf('%s/template%.4d.png',final_templates_directory,num_templates);
    imwrite(mask,template_name)

    num_templates=num_templates+1;
    template_name=sprintf('%s/template%.4d.png',final_templates_directory,num_templates);
    imwrite(fliplr(mask),template_name)
end    