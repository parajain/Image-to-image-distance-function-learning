function [trainimages,trainlabels] = readtrain(path,num_train_percat)
	load(path);
	trainimages = cell(1,num_train_percat * 10);
	trainlabels = zeros(1,num_train_percat * 10);
	count = 1;
	for c = 1 : 10
		index = find(labels == c-1,num_train_percat);
		for i = index'
			%disp(i);	
			X = data(i,:);	
			I = reshape(X',[32,32,3]);
			I = rgb2gray(I);
			trainimages{count} = I;
			trainlabels(count) = labels(i);
			count = count + 1;
		end			
	end
	%filename = strcat('traindata',num2str(num_train_percat),'.mat');
	%save(filename,'trainimages','trainlabels');
end
