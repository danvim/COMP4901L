function [affineMBContext] = initAffineMBTracker(img, rect)
x=rect(1);
y=rect(2);
w=rect(3);
h=rect(4);

T = double(img(y:y+h-1, x:x+w-1))/255.0;
[dTx,dTy] = gradient(T);

% flatten to column vectors
T = T(:);
dT = [dTx(:), dTy(:)];

[X,Y] = meshgrid(y:y+h-1, x:x+w-1);
X=X(:);
Y=Y(:);

%[Y,X] = meshgrid(y:y+h-1,x:x+w-1);
%    X=X(:);
%    Y=Y(:);

o=ones(size(X));

J = [dT dT dT].*[X X Y Y o o];

affineMBContext.J = J;
affineMBContext.invH = (J'*J)^(-1);
