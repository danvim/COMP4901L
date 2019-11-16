batch_size = 2;
input_dim = 4*5*6;
output_dim = 3;

input_size = batch_size * input_dim;
weight_size = output_dim * input_dim;

x = reshape(linspace(-0.1, 0.5, input_size), input_dim, batch_size);
w = reshape(linspace(-0.2, 0.3, weight_size), output_dim, input_dim)';
b = linspace(-0.3, 0.1, output_dim);

input.data = x;
param.w = w;
param.b = b;

input.width = batch_size;
input.height = input_dim;
input.channel = 1;
input.batch_size = batch_size;

output = inner_product_forward(input, 0, param);

correct_out = [ 1.49834967,  1.70660132,  1.91485297;
                3.25553199,  3.5141327,   3.77273342]';

err = rel_error(output.data, correct_out);

fprintf('error of inner product forward: %i\n', err)
