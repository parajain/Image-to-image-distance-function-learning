%Create X_ijk matrix of same size as of W such that all of its entries are zero except the
%subranges corresponding to k and j , which are set to d_ki and – d_ji

function [X] = getX(d,F,N,train_labels,cumm_sum)
	num_cat = 10;%size(categories,2);
    X = [];
	for c = 1 : num_cat
		%category = categories{c};
        category = c-1;
        
        disp(category);
		%Generate pairs from same category
		% will need this if train labels are strings
		%vec1 = find(strcmp(category,train_labels));
        vec1 = find(category == train_labels);
		[p,q] = meshgrid(vec1, vec1); %?
		pairs = [p(:) q(:)];
		num_pairs = size(pairs,1);
		%creating triplets , one from another category
	    % will need this if train labels are strings
        % cat2_id = find(~strcmp(category,train_labels));
        cat2_id = find( category ~= train_labels);
        cat2_id = cat2_id';
        Xijk = zeros(1,N);
		for cat2 = cat2_id		
			for p = 1 : num_pairs
				dij = d{pairs(p,:)};
				dkj = d{cat2,pairs(p,2)};				
				Xijk(1,:) = 0; 
				pi = sum(cumm_sum(1:pairs(p,1)-1));
				pk = sum(cumm_sum(1:cat2-1));
                if size(dij,1) ~= 0
                    Xijk(pi+1:pi+size(dij,1)) = -dij';
                end
                if size(dkj,1) ~= 0
                    Xijk(pk+1:pk+size(dkj,1)) = dkj';  
                end
                X = [X ; Xijk];
			end
		end
	end		
end
