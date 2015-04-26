%close all
%clear all
%clc

%Will open the templates_train directory and some of them will be stored into Templates_test

video_dir='./Videos';
templates_directory='Templates_train';
final_templates_directory='./Templates_test';
mkdir Templates_test;

dir=sprintf('cd ''%s''',pwd);
templates_dir=sprintf('cd %s/',templates_directory);
eval(templates_dir);

% --- for windows
%number_masks=ls;

%unix system command here
[sts,number_masks] = system('ls -1 | wc -l'); 
number_masks = str2num(number_masks);
%number_masks
eval (dir);
ratio_values=[];

hash_matrix = zeros(64,number_masks*5);
 
 %HASH MATRIX
for j=1:number_masks
    name_mask=sprintf('%s/template%.4d.png',templates_directory,j);
    mask=imread(name_mask);
    
    halfV = floor(size(mask,1)/2);
    halfH = floor(size(mask,2)/2);
    hash_matrix(:,j) = HashPic(mask);
    hash_matrix(:,j+1) = HashPic(mask(1:halfV,:));
    hash_matrix(:,j+2) = HashPic(mask(halfV:end,:));
    hash_matrix(:,j+3) = HashPic(mask(:,1:halfH));
    hash_matrix(:,j+4) = HashPic(mask(:,halfH:end));    
end
 
index=1:number_masks-2;         
chosen_templates=index(1:1:size(index,2));    
 %    number_masks;
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
    name_mask=sprintf('%s/template%.4d.png',templates_directory,chosen_templates(n));
    mask=imread(name_mask);
    
    num_templates=num_templates+1;
    template_name=sprintf('%s/template%.4d.png',final_templates_directory,num_templates);
    imwrite(mask,template_name)
    
    num_templates=num_templates+1;
    template_name=sprintf('%s/template%.4d.png',final_templates_directory,num_templates);
    imwrite(fliplr(mask),template_name)
    
end    