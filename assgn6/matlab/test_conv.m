x_shape = [4, 4, 3, 2];
w_shape = [3, 3, 4, 4];
x = reshape(linspace(-0.1, 0.5, 4*4*3*2),4*4*3,2);
w = reshape(linspace(-0.2, 0.3, 3*3*4*4),3*4*4,3);
b = linspace(-0.1, 0.2, 3);

%conv_param = {'stride': 2, 'pad': 1}
input.data = x;
input.height = 4;
input.width = 4;
input.channel = 3;

layer.k = 4;
layer.pad = 1;
layer.stride = 2;
layer.num = 3;
layer.group = 1;

param.w = w;
parma.b = b;

output = conv_layer_forward(input, layer, param);

correct_out = [-0.08759809, -0.10987781,-0.18387192, -0.2109216 ,0.21027089,  0.21661097,0.22847626,  0.23004637,0.50813986,  0.54309974,0.64082444,  0.67101435;
               -0.98053589, -1.03143541,-1.19128892, -1.24695841,0.69108355,  0.66880383,0.59480972,  0.56776003,2.36270298,  2.36904306,2.38090835,  2.38247847]';

err = rel_error(output.data, correct_out)
