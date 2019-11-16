%rand('seed',1);

%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
correct = 0;
y = zeros(size(ytest));
for i=1:100:size(xtest, 2)
%i=1;
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [~,y(i:i+99)] = max(P);
    correct = correct + sum(y(i:i+99)==ytest(i:i+99));
end
%labels(1:10)
%ytest(1:10)
fprintf('accuracy = %i\n',correct/size(xtest, 2));
[c,cm,ind,per] = confusion(ind2vec(ytest),ind2vec(y));
disp(cm);
