layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;


layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
imshow(img')

%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
% Fill in your code here to plot the features.
%imshow(output_1')


for ii = 1:2
    figure;
    output{ii};
    c = o.channel;
    x = o.data;
    w= o.width;
    h=o.height;
    d = w*h;
    for cc = 0:c-1
        im = x(cc*d+1:cc*d+d);
        subplot(4,5,cc+1);
        imshow(reshape(im,h,w)');
    end
end
