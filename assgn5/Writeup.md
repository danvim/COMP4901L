# COMP4901L Assignment5 Writeup

>WONG Yuk Chun (ycwongal, 20419764)
>
>CHEUNG Daniel (dcheungaa, 20423088)

## 1.1 Extract Filter Responses

Original

![](data/airport/sun_aerinlrdodkqnypz.jpg)

Filter 1 on L,A,B respectively

![1.1_im1](saved_figures/1.1im1.jpg)

Filter 6 on L,A,B respectively

![1.1_im2](saved_figures/1.1im2.jpg)

Filter 10 on  L,A,B respectively

![1.1_im3](saved_figures/1.1im3.jpg)

There are some squares in the images, which is due to the lossy compression of JPG format.

The LAB color system is based on human inceptions on color, in contrast with RGB system that is based on hardware requirement. L refer to the brightness, a and b refer to the color balance. We use Lab color system to simulate human inception on colors.

## 1.2 Collect sample of points from image

Blue circles are random points, red circles are harris corners

![](saved_figures/1.2im1.jpg)

![](saved_figures/1.2im2.jpg)

![](saved_figures/1.2im3.jpg)

## Q2.1 Convert image to word map

Left: original, Center: random, Right: Harris

1. ![](saved_figures/2.1im1.jpg)

2. ![](saved_figures/2.1im2.jpg)

3. ![](saved_figures/2.1im3.jpg)

4. ![](saved_figures/2.1im4.jpg)

5. ![](saved_figures/2.1im5.jpg)

6. ![](saved_figures/2.1im6.jpg)

It can extrat some semantic meanings, for example, in figure 3, it can extract sky, tree and buildings. Harris seems to be better since it can extract semantic meanings of some fine details, such as in figure 2 it can extract many lights on the ceiling which the random one cannot extract.

