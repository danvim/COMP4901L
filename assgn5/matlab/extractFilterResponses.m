function [filterResponses] = extractFilterResponses(I, filterBank)
    [L,A,B] = RGB2Lab(I);
    [fno,~] = size(filterBank);
    filterResponses = cell(fno*3,1);
    for  i=1:fno
        filterResponses{3*(i-1)+1} = conv2(L, filterBank{i});
        filterResponses{3*(i-1)+2} = conv2(A, filterBank{i});
        filterResponses{3*(i-1)+3} = conv2(B, filterBank{i});
    end;
