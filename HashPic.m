function hash = HashPic(i)
%i is assumed to be grayscale

%Reduce size to 8x8
i1s = imresize(i,[8 8]);

%Compute the mean
mean = mean2(i1s);
[X,Y] = size(i1s);

%Compute the bits
i1s(i1s>=mean) = 1;
i1s(i1s<mean) = 0;


%Transform matrix to array
i1s = i1s(:)';

%hash = num2str(i1s);
hash = i1s;
end