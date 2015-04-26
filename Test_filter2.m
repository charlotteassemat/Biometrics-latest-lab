close all
clc

%read a new frame for a new video input
name_mask='frame0009.png';
mask=(imread(name_mask));

%read a template extrated from the previous lab
name_template='template0009.png';
template=(imread(name_template));

%Display the new frame and the template
figure,imshow(mask)
figure,imshow(template)

%Calculate the correlation between the template and the new frame
%normalized between 0 and 1
template=template/sum(sum(template));
Correlation=filter2(template,mask);

%
[xymax,smax]=extrema2(Correlation)

%Display the result of the correlation
%white means high correlation between the template and the original frame
%in a given region
%localize the center of the match
%higher confidence this is a person  (extrapolate heght weight)
figure,imshow(Correlation)