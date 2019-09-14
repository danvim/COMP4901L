function [img1] = myEdgeFilter(img0, sigma)
%Your implemention
 hsize = 2 * ceil(3 * sigma) + 1;
  h = fspecial('gaussian',hsize,sigma);
  
  A = myImageFilter(img0, h);
  
  imgx = myImageFilter(A,fspecial('sobel')); % horizontal edge
  imgy = myImageFilter(A,fspecial('sobel')'); % verticle edge
  
  G = sqrt(imgx.^2 + imgy.^2);
  angles = mod(atan2(imgy, imgx),deg2rad(180));
  
  idx0 = (angles < deg2rad(45/2)) | ((deg2rad(180) - angles) <= deg2rad(45/2));
  idx45 = angles >= deg2rad(45/2) & angles < deg2rad(45 + 45/2);
  idx90 = angles >= deg2rad(45+45/2) & angles < deg2rad(90 + 45/2);
  idx135 = angles >= deg2rad(90+45/2) & angles < deg2rad(135 + 45/2);
  
  [h,w] = size(G);
  pG = padarray(G,[1,1],0);
  NMS = zeros(size(G));
  
  % 0
  G1 = pG(2:h+1,1:w);
  G2 = pG(2:h+1,3:w+2);
  NMS = NMS | idx0 & (G >= G1 & G >= G2);
  
  % 45
  G1 = pG(1:h+0,3:w+2);
  G2 = pG(3:h+2,1:w+0);
  NMS = NMS | idx45 & (G >= G1 & G >= G2);
  
  % 90
  G1 = pG(1:h+0,2:w+1);
  G2 = pG(3:h+2,2:w+1);
  NMS = NMS | idx90 & (G >= G1 & G >= G2);
  
  % 135
  G1 = pG(1:h+0,1:w+0);
  G2 = pG(3:h+2,3:w+2);
  NMS = NMS | idx135 & (G >= G1 & G >= G2);
  
  img1 = G;
  %img1(~NMS) = 0;
end
    
                
        
        
