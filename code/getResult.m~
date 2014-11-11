%This function creates a confusion matrix plot.

function getResult(predicted_categories,test_labels,num_categories)

	categories = zeros(1,num_categories);
	for i = 1 : num_categories
		categories(i) = i-1;
	end
	

	confusion_matrix = zeros(num_categories, num_categories);
	for i=1:length(predicted_categories)
		row = find(test_labels(i) == categories);
		column = find(predicted_categories(i) == categories);
		confusion_matrix(row, column) = confusion_matrix(row, column) + 1;
	end


	num_test_per_cat = length(test_labels) / num_categories;
	confusion_matrix = confusion_matrix ./ num_test_per_cat;   
	accuracy = mean(diag(confusion_matrix));
	fprintf(     'Accuracy (mean of diagonal of confusion matrix) is %.3f\n', accuracy)

	fig_handle = figure; 
	imagesc(confusion_matrix, [0 1]); 

end
