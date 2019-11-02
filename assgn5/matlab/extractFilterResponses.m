function [filterResponses] = extractFilterResponses(I, filterBank)
    [~,~,x] = size(I);
    if x == 3
        [L,A,B] = RGB2Lab(I);
    else
        L = I;
        A = I;
        B = I;
    end
    [fno,~] = size(filterBank);
    [H,W] = size(L);
    filterResponses = zeros(H,W,fno*3);
    for  i=1:fno
        filterResponses(:,:,3*(i-1)+1) = conv2(L, filterBank{i}, 'same');
        filterResponses(:,:,3*(i-1)+2) = conv2(A, filterBank{i}, 'same');
        filterResponses(:,:,3*(i-1)+3) = conv2(B, filterBank{i}, 'same');
    end;
