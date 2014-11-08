%// gedit hack%
%Parag Jain
%Paper : Learning Globally-Consistent Local Distance Functions for Shape-Based Image Retrieval and Classification
%=================================================================================================================

%Path for training data
%We are using any one batch since training data is small
train_path = '../dataset/cifar-10-batches-mat/data_batch_1.mat';
test_path = '../dataset/cifar-10-batches-mat/test_batch.mat';

num_train_per_cat = 3; 
%Total number of test to be done,test_batch is already randomized so we are not randomizing 
num_test = 10;

%Type of feature to be used,any patch based feature will work.Author has used sift.
%TYPE = 'PHOW';
TYPE = 'SIFT';

%% Get data
fprintf('Getting images and labels for train and test data\n')
[train_images,trainlabels] = readtrain(train_path,num_train_per_cat);
[test_images,testlabels] = readtest(test_path,num_test);

%% Extract features
% Add vlfeat directory to path or use run(pathto vl_setup) function
vl_setup;
fprintf('Extracting features\n')
%Calculate SIFT features for each image i call it as F_i also let f_i,m the m th feature of i^th image.
[F , N , W,cumm_sum] = get_image_features(train_images,TYPE);


%% Get distance
fprintf('Geting distance\n')
%This is distance matrix d,it  contains distance between features for all pairs if image
%Calculate a matrix d_ji,m which is the smallest distance between f_j,m and any member of the set F_i
[d] = get_distance(F);

X = getX(d,F,N,trainlabels,cumm_sum);


%% Code for optimization here using quadprog function


num_w = size(W,2);
num_dim = 128;%sift
num_examples = size(X,1);
H = eye(num_w+1);
H(num_w+1,num_w+1) = 0;
f = zeros(num_w+1,1);
A = -1*[X ones(num_examples,1)];
c = -1*ones(num_examples,1);
% l is the lower bound for weights which is zero
l = zeros(num_w+1,1);
l(num_w+1,1) = 1;
options = optimset('Algorithm','interior-point-convex');
[w,fval] = quadprog(H,f,A,c,[],[],l,[],[],options);

%% Predict

[predicted] = classify(test_images,trainlabels,F,w,cumm_sum,TYPE);
filename = 'final.mat';
save(filename,'predicted');
predicted_cat = cell2mat(predicted);
getResult(predicted_cat,test_labels,10);


