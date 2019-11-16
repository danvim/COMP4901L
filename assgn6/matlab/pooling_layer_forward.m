function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;


    % Replace the following line with your implementation.
    output.data = zeros([h_out, w_out, c, batch_size]);

    input_n.height = h_in;
    input_n.width = w_in;
    input_n.channel = 1;

    for n = 1:batch_size
        A = padarray(reshape(input.data(:,n),h_in,w_in,c),[pad pad],'replicate','both');
        for cc = 1:c
            input_n.data = reshape(A(:,:,cc),h_in*w_in,1);
            col = im2col_conv(input_n, layer, h_out, w_out);
            col = max(reshape(col,k*k,h_out*w_out));
            output.data(:,:,cc,n) = reshape(col, h_out,w_out);
%            for h = 1:h_out
%                for w = 1:w_out
%                    hr = ((h-1)*stride+1) : ((h-1)*stride+k);
%                    wr = ((w-1)*stride+1) : ((w-1)*stride+k);
%                    q=A(hr, wr,cc);
%                    output.data(h,w,cc,n) = max(max(q));
%                end
%            end
        end
    end
    output.data = reshape(output.data, h_out*w_out*c, batch_size);
end

