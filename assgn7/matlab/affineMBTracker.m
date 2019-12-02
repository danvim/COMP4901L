function [Wout] = affineMBTracker(img, tmp, rect, Win, context)
    maxIter = 100;
    x=rect(1);
    y=rect(2);
    w=rect(3);
    h=rect(4);

    [Y,X] = meshgrid(x:x+w-1, y:y+h-1);
    X=X(:);
    Y=Y(:);
    o=ones(size(X));

    T = tmp(:);

    invH = context.invH;
    J = context.J;

    Wout = Win;

    eps = 1e-3;

    for i = 1:maxIter
%        tform = affine2d(Wout);
        C = Wout*[X';Y';o'];
        X_ = floor(C(1,:)');
        Y_ = floor(C(2,:)');
%        reshape(X_,[w,h])
%        reshape(Y_,[w,h])
        I = img(sub2ind(size(img),X_,Y_));
%        size(I)
%        size(T)
%        imshow(reshape(I,[h,w]));
%        imshow(reshape(T,[h,w]));
%        pause;
%        warpedI = warpH(img,inv(Wout),size(img),0);
%        I=img(y:y+h-1,x:x+w-1);II
        dp = invH * J' * double(I-T)/255.0;
        Wout = Wout*Wp(dp);

        if norm(dp) < eps
            fprintf("break at iter %i, dp %i\n",i,norm(dp));
            break;
        end

        fprintf("iter %i, dp %i\n",i, norm(dp))
    end
