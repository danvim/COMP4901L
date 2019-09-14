function [img1] = myImageFilter(img0, h)      
    A = img0;
    
    % add padding so the result have same size
    B = padarray(A,(size(h)-1)/2,'replicate');
    
    % change the matrix into columns of where the kernel will cover
    C = im2col(B,size(h));
    
    % convert the kernal into vector
    % hr = rot90(h, 2);
    E = h(:);
    
    % each column of C dot product with kernal vector
    % equivalent with doing convolution
    F =  C.*E;
    G = sum(F);
    
    % convert the vector back to matrix
    H = reshape(G,size(A));
    H = rot90(H,2);
    img1 = H
    
    % commented code is for varifying the vectorized code is correct
    %  expected = conv2(B,h,'valid');
    %  img1 = expected;
    %  if(~isequal(img1, expected))
    %     disp(img0);
    %     disp('img1');
    %     disp(img1);
    %     disp('expected');
    %     disp(expected);
    %     disp('img1 - expected');
    %     disp(img1-expected);
    %     assert(false);
    % end
end
