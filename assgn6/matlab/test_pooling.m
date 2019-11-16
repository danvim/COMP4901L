x_shape = [4, 4, 3, 2];
x = reshape(linspace(-0.3, 0.4, 4*4*3*2),4*4*3,2);
%pool_param = {'pool_width': 2, 'pool_height': 2, 'stride': 2}

%reshape(x,x_shape)

input.data = x;
input.height = 4;
input.width = 4;
input.channel = 3;

layer.k = 2;
layer.pad = 0;
layer.stride = 2;

output = pooling_layer_forward(input, layer);

%output.data

%size(output.data)

correct_out =  [-0.26315789, -0.24842105, -0.20421053, -0.18947368, -0.14526316, -0.13052632, -0.08631579, -0.07157895, -0.02736842, -0.01263158,  0.03157895,  0.04631579;
                 0.09052632,  0.10526316, 0.14947368,  0.16421053, 0.20842105,  0.22315789, 0.26736842,  0.28210526, 0.32631579,  0.34105263, 0.38526316,  0.4]';

%                 size(correct_out)

err = rel_error(output.data, correct_out);

fprintf('error of max pooling forward = %i \n',err);
