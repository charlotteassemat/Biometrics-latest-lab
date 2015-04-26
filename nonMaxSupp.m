function max_blobs = nonMaxSupp(blobs, overlap)
% pick = nms(boxes, overlap) 
% Non-maximum suppression.
% Greedily select high-scoring detections and skip detections
% that are significantly covered by a previously selected detection.
display('entering non max supp')
    num_images = size(blobs,2);
    for i=1:num_images
        if isempty(blobs)
            display('no blob found');
            max_blobs{i} = [];
        else
            max_blobs{i} = nonMaxSupp_frame(blobs{i},overlap);
        end
    end
end

function blobs = nonMaxSupp_frame(blobs,overlap)
  if isempty(blobs)
      display('warning: not blob found')
  else
    x1 = [blobs(:).x];
      y1 = [blobs(:).y];
      x2 = x1 + [blobs(:).h];
      y2 = y1 + [blobs(:).w];
      s = [blobs(:).score];
      area = (x2-x1+1) .* (y2-y1+1);
      [~, I] = sort(s);
      pick = [];
      while ~isempty(I)
        i_last = length(I);
        i = I(i_last);
        pick = [pick; i];
        suppress = [i_last];
        for pos = 1:i_last-1
          j = I(pos);
          xx1 = max(x1(i), x1(j));
          yy1 = max(y1(i), y1(j));
          xx2 = min(x2(i), x2(j));
          yy2 = min(y2(i), y2(j));
          w = xx2-xx1+1;
          h = yy2-yy1+1;
          if w > 0 && h > 0
            % compute overlap 
            o1 = w * h / area(j);%compare min 2 blobs to orig blob
            o2 = w * h / area(i);
            if o1 > overlap || o2 > overlap%comp
              suppress = [suppress; pos];
            else
              display('not suppressed computed overlap')
              o1
              o2
            end
          end
        end
        I(suppress) = [];
      end
      blobs = blobs(pick);
  end
end