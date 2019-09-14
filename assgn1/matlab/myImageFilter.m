function [img1] = myImageFilter(img0, h)  
    A = img0;
    
    % add padding so the result have same size
    B = padarray(A,(size(h)-1)/2,'replicate');
    
    % change the matrix into columns of where the kernel will cover
    C = im2col(B,size(h));
    
    % convert the kernal into vector
    E = h(:);
    
    % each column of C dot product with kernal vector
    % equivalent with doing convolution
    F =  C.*E;
    G = sum(F);
    
    % convert the vector back to matrix
    H = reshape(G,size(A));
    
    % commented code is for varifying the vectorized code is correct
    %hr = rot90(h, 2);
    %expected = conv2(B,hr,'valid');
    %disp(H);
    %disp(expected);
    %assert(isequal(H, expected));
    img1 = H;
end
