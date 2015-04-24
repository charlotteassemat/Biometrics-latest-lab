function [xymax, smax] = correlation_filter2(template, mask)

%mask = (imread(name_mask));
%template = (imread(name_template));

%Display the new frame and the template
%figure,imshow(mask)
%figure,imshow(template)

%Calculate the correlation between the template and the new frame
template = template/sum(sum(template));
Correlation = filter2(template,mask);
[xymax,smax] = extrema2(Correlation);

%figure,imshow(Correlation)

end

