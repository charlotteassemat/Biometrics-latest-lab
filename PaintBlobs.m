function imagen=PaintBlobs(blobs,imagen,color)
% if(size(blobs,2)==1)
%     blob=blobs(1);
% else    
%     Xs=blobs(:,2).x;
%     %Xs=Xs';
%     Ys=blobs(:,2).y;
%     %Ys=Ys';
%     Ws=blobs(:,2).w;
%     Hs=blobs(:,2).h;
%     %Ws=Ws';
%     %Hs=Hs';
%     
%     Xvs = [Xs' (Xs+Ws)' (Xs+Ws)' Xs'];
%     Yvs = [(Ys+Hs)' (Ys+Hs)' Ys' Ys'];
% 
%     pointsIn=inpolygon(Xs,Ys,Xvs,Yvs);
%     Areas=Ws.*Hs;
%     find((pointsIn./Areas)>0.5);
%     blob=blobs(i);
% end
%     imagen=PaintBlob(blob,imagen,color);
    
for i=1:size(blobs,2)
    blob=blobs(i);
    imagen=PaintBlob(blob,imagen,color);
end

