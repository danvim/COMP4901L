function E = essentialMatrix(F, K1, K2)
% essentialMatrix computes the essential matrix 
%   Args:
%       F:  Fundamental Matrix
%       K1: Camera Matrix 1
%       K2: Camera Matrix 2
%
%   Returns:
%       E:  Essential Matrix
%

% X_1' * E * X_2 = 0
% (inv(K_1) * P_1)' * E * (inv(K_2) * P_2) = 0
% P_1' * inv(K_1)' * E * inv(K_2) * P_2 = 0
% P_1' * F * P_2 = 0
% F = inv(K_1)' * E * inv(K_2)
% K_1' * F = E * inv(K_2)
% K_1' * F * K_2 = E

E = K1' * F * K2;
