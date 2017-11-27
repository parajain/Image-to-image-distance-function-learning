Learning Globally-Consistent Local Distance Functions for Shape-Based Image Retrieval and Classification
=========================================================================================================
https://www2.eecs.berkeley.edu/Research/Projects/CS/vision/shape/papers/FromeSingerShaMalikICCV07.pdf



How to run code:

	1. Main script is in main.m
	2. Set test and train data path.
	3. All the parameter have been set such that whole pipeline of code can run within 20-25 minutes and not for optimal performance.
	4. Some parts have used parallel for loops,use matlabpool to 

Dependencies:
	1. For calculating SIFT features I have used vl_feat library,add it to path before running main.m
	2. For solving the optimization problem I have used matlab quadratic programming function quadprog()
	

Dataset:

	I have used cifar-10 dataset.
	link : http://www.cs.toronto.edu/~kriz/cifar.html
	Download matlab version and update the path in the main.m file.
	
