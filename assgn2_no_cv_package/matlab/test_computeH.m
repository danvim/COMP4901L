H = [
    9 8 7;
    6 5 4;
    4 80 1
    ];

p1 = [2 2 1; 4 8 1; 2 -2 1; 30 -4 1];

p2 = (H * p1')';

p2 = p2 ./ p2(:,3); 

H_ = computeH_norm(p2, p1);
H_ = H_ ./ H_(3,3);