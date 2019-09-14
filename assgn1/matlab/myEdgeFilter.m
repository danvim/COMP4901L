function [img1] = myEdgeFilter(img0, sigma)
%Your implemention
 hsize = 2 * ceil(3 * sigma) + 1;
  h = fspecial('gaussian',hsize,sigma);
  
  A = myImageFilter(img0, h);

  imgx = myImageFilter(A,-1*[-1 0 1; -2 0 2; -1 0 1]); % horizontal edge
  imgy = myImageFilter(A,-1*[-1 -2 -1; 0 0 0; 1 2 1]); % verticle edge
  
  G = sqrt(imgx.^2 + imgy.^2);
  angles = mod(rad2deg(atan2(imgy, imgx)),180);
  
  idx0 = (angles < 45/2) | (180 - angles) <= (45/2);
  idx45 = angles >= (45/2) & angles < (45 + 45/2);
  idx90 = angles >= (45+45/2) & angles < (90 + 45/2);
  idx135 = angles >= (90+45/2) & angles < (135 + 45/2);
  
  [h,w] = size(G);
  pG = padarray(G,[2,2],0);
  NMS = zeros(size(G));
  
  % 0
  G1 = pG(3:h+2,1:w+0);
  G2 = pG(3:h+2,2:w+1);
  G3 = pG(3:h+2,4:w+3);
  G4 = pG(3:h+2,5:w+4);
  NMS = NMS | idx0 & (G >= G1 & G >= G2 & G >= G3 & G>=G4);
  
  % 45
  G1 = pG(1:h+0,1:w+0);
  G2 = pG(2:h+1,2:w+1);
  G3 = pG(4:h+3,4:w+3);
  G4 = pG(5:h+4,5:w+4);
  NMS = NMS | idx45 & (G >= G1 & G >= G2 & G >= G3 & G>=G4);
  
  % 90
  G1 = pG(1:h+0,3:w+2);
  G2 = pG(2:h+1,3:w+2);
  G3 = pG(4:h+3,3:w+2);
  G4 = pG(5:h+4,3:w+2);
  NMS = NMS | idx90 & (G >= G1 & G >= G2 & G >= G3 & G>=G4);
  
  % 135
  G1 = pG(1:h+0,5:w+4);
  G2 = pG(2:h+1,4:w+3);
  G3 = pG(4:h+3,2:w+1);
  G4 = pG(5:h+4,1:w+0);
  NMS = NMS | idx135 & (G >= G1 & G >= G2 & G >= G3 & G>=G4);
  
  img1 = G;
  img1(~NMS) = 0;
end