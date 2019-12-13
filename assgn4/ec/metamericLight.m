%load('../data/bananas.mat');
%f = ripe;
%g = overripe;

function T=metamericLight(f,g)
csv = csvread('../data/ciexyz64_1.csv');
l0 = 400;
dl = 10;
ln = 700;
idx = find(csv(:,1)==l0);
R = csv(idx:dl:(idx+ln-l0) ,2:4)';
%size(R)
lambdas = (l0:dl:ln)*1e-9;
a = 1.4388e-2;

minD = Inf;
minT = 0;

L_T = @(T,ls) normalize(1./ls.^5 *1./(exp(a./(ls.*T))-1),'norm',1);

Ts=2500:1:10000;

i=1;
Ds = zeros(size(Ts));
for T=Ts
    l = L_T(T,lambdas);
%    l = l./sum(l);
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
xlabel('Temperature(K)')
ylabel('distance')
title('distance as a function of temperature')

subplot(1,2,2)
plot(1:4000,L_T(minT,(1:4000)*1e-9));
ylabel('Power')
xlabel('Wavelength(nm)')
title('spectral power distribution of the best illuminant')
disp(minT)
T = minT;
