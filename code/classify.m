%this function get the categories of test images
%This function implements nearest neighbour classifier
function [predicted] = classify(test_images,train_labels,F,w,cumm_sum,TYPE)
	num_test = size(test_images,2);
	num_train = size(F,1);
    predicted = cell(num_test,1);
	for i = 1 : num_test
		I = test_images{i};
	%	I = imresize(I,[32 32]);
		if size(I, 3) == 3
    			I = rgb2gray(I);
        end
        if TYPE == 'SIFT'
            [loc ,features] = vl_dsift(single(I));
        else
            [loc ,features] = vl_phow(single(I));
        end
        
		alldist = zeros(num_train,1);
		for j = 1 : num_train
			numfeat = size(F{j},1);
			trainfeat = F{j};
			pj = sum(cumm_sum(1:j-1));
			wt = w(pj+1:pj+size(F{j},1));
			dist = zeros(numfeat,1);
			for k = 1 : numfeat
				D = vl_alldist2(trainfeat(k,:)',features);%'
				dist(k) = min(D);
            end           
            %disp(size(wt));
            dt = wt.*dist;
			alldist(j) = sum(dt);
		end
		%1-NN,directly use min
		%[v,index] = min(alldist);
		sorted_dist = sort(alldist);
		[val,index] = mode(sorted_dist(1:10));
		predicted{i} = train_labels(index);
        %predicted{i} = index;
	end
end
