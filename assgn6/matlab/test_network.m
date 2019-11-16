rand('seed',1);

%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet_pretrained.mat


[confusions] = deal(zeros(10,10));

%% Testing the network
% Modify the code to get the confusion matrix
%for i=1:100:size(xtest, 2)
i=1;
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [~,labels] = min(P);
%end
labels(1:10)
ytest(1:10)
