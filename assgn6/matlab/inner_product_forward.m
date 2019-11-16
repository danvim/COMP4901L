function [output] = inner_product_forward(input, layer, param)
d = size(input.data, 1);
k = size(input.data, 2); % batch size
n = size(param.w, 2);

% Replace the following line with your implementation.
%output.data = zeros([n, k]);

output.data = (input.data' * param.w  + param.b)';

output.width = input.width;
output.height = n;
output.channel = input.channel;
output.batch_size = input.batch_size;

end
