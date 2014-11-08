%Calculate a matrix d_ji,m which is the smallest distance between f_j,m and any member of the set F_i
%
%Input:
%		Cell array F,containing features for each image.
%Output:
%		d = cell matrix,d{i,j} = distance between features between image i and j
%			**d is not symmetric**


function [d] = get_distance(F)
	num_images = size(F);
	d = cell(num_images,num_images);

	for i = 1 : num_images
		c = F{i};
		numfeat = size(c,1);		
		for j = 1 : num_images
			if i == j 
				continue;
			end
		dist = zeros(numfeat,1);
		%find minimum distance feature for k^th feature of image i and all feature of image j
			for k = 1 : numfeat
				D = vl_alldist2(c(k,:)',F{j}');%'
				dist(k) = min(D);
			end		
			d{i,j} = dist;
		end
	end
end 
