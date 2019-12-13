function T=metamericLight(f,g)
csv = csvread('../data/ciexyz64_1.csv');
l0 = 400;
dl = 10;
ln = 700;
idx = find(csv(:,1)==l0);
R = csv(idx:dl:(idx+ln-l0) ,2:4)';
%size(R)
lambdas = l0:dl:ln;
a = 1.4388e-2;

minD = Inf;
minT = 0;


Ts=2500e3:50e3:10000e3;

i=1;
Ds = zeros(size(Ts));
for T=Ts
    l = 1./lambdas.^5 *1./(exp(a./(lambdas.*T))-1);
    l = l./sum(l);
%    Cf = R*(f.*l);
%    Cg = R*(g.*l);
    Cf = R.*repmat(f',[3,1])*l';
    Cg = R.*repmat(g',[3,1])*l';
    D = norm(Cf-Cg);
    Ds(i)=D;
    i=i+1;
    if D < minD
        minD = D;
        minT = T;
        minl = l;
    end
end
subplot(1,2,1)
plot(Ts,Ds);
title('distance as a function of temperature')

subplot(1,2,2)
plot(lambdas,minl);
title('spectral power distribution of the best illuminant')
disp(minT)
T = minT;
