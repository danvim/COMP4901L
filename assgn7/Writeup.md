# COMP4901L Assignment7 Writeup

>WONG Yuk Chun (ycwongal, 20419764)
>
>CHEUNG Daniel (dcheungaa, 20423088)

## Part 1 Theory Questions

### Q1.1: Calculating the Jacobian

$$
\let\vec\mathbf
\text{Assuming}\\

\vec{W}(\vec{x};\vec{p})=\begin{bmatrix}
\vec{W}_x\\ \vec{W}_y\\ \vec{W}_1
\end{bmatrix}\begin{bmatrix}
u\\v\\1
\end{bmatrix}=\begin{bmatrix}
1+p_1&		p_3&		p_5\\
p_2&		1+p_4&		p_6\\
0&			0&			1
\end{bmatrix}\begin{bmatrix}
u\\v\\1
\end{bmatrix}\\

\text{and,}\\

\vec{p}=\begin{bmatrix}p_1&p_2&p_3&p_4&p_5&p_6\end{bmatrix}^T\\
$$

$$
\begin{align}
\frac{\part\vec{W}}{\part\vec{p}}&=\begin{bmatrix}
\frac{\part\vec{W}_u}{\part\vec{p}_1}& \dots& \frac{\part\vec{W}_u}{\part\vec{p}_6}\\
\frac{\part\vec{W}_v}{\part\vec{p}_1}& \dots& \frac{\part\vec{W}_v}{\part\vec{p}_6}\\
\end{bmatrix}\\
&=\begin{bmatrix}
u&	0&	v&	0&	1&	0\\
0&	u&	0&	v&	0&	1
\end{bmatrix}
\end{align}
$$

$$
L = \sum_\vec{x}[\vec T(x) - \vec I(\vec W)]^2
$$


$$
\begin{align}
\vec{J} = \frac{\part L}{\part\vec p} &= \frac{\part L}{\part\vec I(\vec W)}\frac{\part\vec I(\vec W)}{\part \vec W}\frac{\part\vec W}{\part\vec p}\\
&=-2\sum_\vec{x}[\vec T(x) - \vec I(\vec W)]\begin{bmatrix}\frac{\part\vec I}{\part u}& \frac{\part\vec I}{\part v}\end{bmatrix}\begin{bmatrix}
u&	0&	v&	0&	1&	0\\
0&	u&	0&	v&	0&	1
\end{bmatrix}
\end{align}
$$


### Q1.2: Computational complexity

#### Initialization step

Evaluate $\nabla\vec T$, which the runtime is $O(n)$

Evaluate $\vec J=\frac{\part\vec{W}}{\part \vec{p}}$ at $\vec{p=0}$, 

To compute $\nabla\vec{T}\frac{\part\vec{W}}{\part \vec{p}}$, since $\nabla\vec T$ is of dimension $(n\times2)$ and $\frac{\part\vec{W}}{\part \vec{p}}$ is of dimension $(2\times p)$, this multiplication will have computational cost $O(np)$.

To compute Hessian matrix $\vec H=\vec{J^T}\vec J$, since $\vec J$ is of dimension $(n\times p)$, this multiplication will have computational cost $O(np^2)$

Thus the initialization cost will be $O(np+np^2)=O(np^2)$.

#### Incremental step

First compute $\vec{I(W(x;p))}$, which is $O(np)$.

Then compute $[\vec{I}(\vec{W(x;p)})-\vec{T}]$, which is $O(n)$.

Then compute $\sum_{\vec x}\vec{(\nabla T\frac{\part W}{\part p})^T}[\vec{I}(\vec{W(x;p)})-\vec{T(x)}]$, which is $O(pn)$.

Then multiply previous result with inverse of Hessian to get $\Delta\vec p$, which is $O(p^3)$.

Then update the warp function, which is $O(p^2)$

Total $O(pn+p^3)$

## Part 2 Lucas-Kanade Tracker

### Q2.1

video in `lk_results/`. initial rects:

car: `[180 180 36 36]`

landing: `[552 126 20 20]`

### Q2.3

video in `mb_results`. initial rects:

car: `[115   96  189  160]`

landing: `[244   43   69   36]`

### Q2.4

The license plate/ bright spot is good

when go under the bridge it is possible to break

because the illuminance level changed greatly, big different everywhere so difficult for the Jacobian to tell which direction is the steepest

## Part 3

### Robust LK

Video in `ilk_results`, initial rect:

car: `[158  144   92   66]`

landing: `[440    79   118    58]`

use `ec/ilk_demo.m` to run

