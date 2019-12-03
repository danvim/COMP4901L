function [Wout] = affineMBTracker(img, tmp, rect, Win, context)
    maxIter = 30;
    x=rect(1);
    y=rect(2);
    w=rect(3);
    h=rect(4);

    [X,Y] = meshgrid(x:x+w-1, y:y+h-1);
    X=X(:);
    Y=Y(:);
    o=ones(size(X));

    T = tmp(:);

    invH = context.invH;
    J = context.J;

    Wout = Win;

    eps = 0.01;
    eps_dp = 1.3;

    for i = 1:maxIter
%        II = imwarp(img,affine2d(Wout'));
%%        pause;
%        I = II(y:y+h-1, x:x+w-1);
%        I = I(:);
%        tform = affine2d(Wout);
        C = Wout*[X';Y';o'];
        C = C ./ C(3,3);
        X_ = floor(C(1,:)');
        Y_ = floor(C(2,:)');
%        reshape(X_,[w,h])
%        reshape(Y_,[w,h])
        I = img(sub2ind(size(img),Y_,X_));

%        size(I)
%        size(T)

%        subplot(1,2,2)
%        imshow(reshape(I,[h,w]));
%        title(sprintf('%i/%i',i,maxIter));
%        drawnow;

%        pause
%        imshow(reshape(T,[h,w]));
%        pause;
%        warpedI = warpH(img,inv(Wout),size(img),0);
%        I=img(y:y+h-1,x:x+w-1);II
        D = (double(I)-double(T))/255.0;
        dp = invH * J' * D;
        Wout = Wout/Wp(dp);
        Wout = Wout./Wout(3,3);

        diff = sum(abs(D))/length(D);
%        if  norm(dp)<eps_dp %diff < eps
%            fprintf("break at iter %i, dp %i diff %i\n",i,norm(dp),diff);
%            break;
%        end

%        fprintf("iter %i, dp %i, diff %i,\n",i, norm(dp),diff)
    end
        fprintf("iter %i, dp %i, diff %i,",i, norm(dp),diff)
