function [testimages,testlabels] = readtest(path,num_test)
	load(path);
	testimages = cell(1,num_test);
	testlabels = zeros(1,num_test);
	
	for i = 1 : num_test
		X = data(i,:);	
		I = reshape(X',[32,32,3]);
		I = rgb2gray(I);
		testimages{i} = I;
		testlabels(i) = labels(i);
	end
	%filename = strcat('testdata',num2str(num_test),'.mat');
	%save(filename,'testimages','testlabels');
end
