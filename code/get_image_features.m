%Calculate SIFT features for each image i call it as F_i also let f_i,m the m th feature of i^th image.
%Input :
%	train_images = cell array of train image
%	TYPE : type of feature to be used
%Output:
%	F = cell array of features,F{i} contains features of image i	
%	N = total number of features in all images, used for further calculation
%	W = random weight matrix,normalized for each image
%	cumm_sum = vector of number of features for each image,used for further calculation
%

function [F,N,W,cumm_sum] = get_image_features(train_images,TYPE)
	M = size(train_images,2);
	F = cell(M,1);
	N = 0;
	cumm_sum = zeros(1,M);
	W = [];
	parfor i = 1 : M
		%I = imread(train_image_paths{i});
		I = train_images{i};
		if TYPE == 'SIFT'
            [loc ,features] = vl_dsift(single(I));
        else
            [loc ,features] = vl_phow(single(I));
        end
		n = size(features,2);		
		%Random sample to reduce number of features to reduces memory and computation usage,this definately reduces the performance
		samp_size = n;
		%samp_size = floor(n/4);
    	%randomsample = randsample(n,samp_size);
		%features = features';
		%features = features(randomsample,:);
		%F{i} = features;		
		F{i} = features';
		%Generate random normalized values for image i
		rndw = rand(1,samp_size);
		norm_rnd = rndw./norm(rndw,1);
		W = horzcat(W,norm_rnd);
		N = N + samp_size;
		cumm_sum(i) = samp_size;
	end
end
