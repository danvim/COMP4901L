# COMP4901L Assignment 2 writeup

> WONG Yuk Chun (ycwongal, 20419764)
>
> CHEUNG Daniel (dcheungaa, 20423088)

# 1. Homographies

## Q1.1 Homography

$$
\bf{x_1}\equiv\bf{H}\bf{x^2}\tag{1}
$$

We know that some $\bf{x_1} = \bf{P_1}\bf{x_\pi}$ for $\bf{x_\pi}$ is the object of the image point $\bf{x_1}$ in as a 3D vector. And the same goes to $\bf{x_2} = \bf{P_2}\bf{x_\pi}$ by definition. Then in the 3D space, the image planes are simply related by one rotational transformation $\bf{R}$ and one translational transformation $\bf{T}$, mapping the camera matrices from one to another.

**(Help me Dipsy 😂)**

## Q1.2 Correspondences

### 1.

8

### 2.

4 pairs of point correspondences

### 3.

$$
\let\vec\mathbf
\text{Assuming we have correspondences } i \text{ from 1 to 4}.\\
\text{From } \vec{x}_1^i \equiv \vec{H}\vec{x_2^i}\text{,}\\

\begin{bmatrix}x_1^i\\y_1^i\\1\end{bmatrix} \equiv 
	\begin{bmatrix}
		h_1 & h_2 & h_3\\
		h_4 & h_5 & h_6\\
		h_7 & h_8 & h_9
    \end{bmatrix}
    \begin{bmatrix}x_2^i\\y_2^i\\1\end{bmatrix}\\
\begin{bmatrix}x_1^i\\y_1^i\\1\end{bmatrix} \equiv
	\begin{bmatrix}
		h_1x_2^i + h_2y_2^i + h_3 \\
		h_4x_2^i + h_5y_2^i + h_6 \\
		h_7x_2^i + h_8y_2^i + h_9 \\
    \end{bmatrix}\\
\begin{bmatrix}x_1^i\\y_1^i\end{bmatrix} \equiv
	\begin{bmatrix}
		\frac{h_1x_2^i + h_2y_2^i + h_3}{h_7x_2^i + h_8y_2^i + h_9} \\
		\frac{h_4x_2^i + h_5y_2^i + h_6}{h_7x_2^i + h_8y_2^i + h_9} \\
    \end{bmatrix}\\
\begin{bmatrix}
	(h_7x_2^i + h_8y_2^i + h_9)x_1^i\\
	(h_7x_2^i + h_8y_2^i + h_9)y_1^i
\end{bmatrix} \equiv
	\begin{bmatrix}
		h_1x_2^i + h_2y_2^i + h_3 \\
		h_4x_2^i + h_5y_2^i + h_6
    \end{bmatrix}\\
\text{Here, we have 2 equations:}\\
- h_1x_2^i - h_2y_2^i - h_3 + (h_7x_2^i + h_8y_2^i + h_9)x_1^i = \vec{0}\\
- h_4x_2^i - h_5y_2^i - h_6 + (h_7x_2^i + h_8y_2^i + h_9)y_1^i = \vec{0}\\
\text{From here, we formulate into form of }\vec{A}_i\vec{h}=\vec{0}\\
\begin{bmatrix}
	-x_2^i & -y_2^i & -1 & 0 & 0 & 0 & x_1^ix_2^i & x_1^iy_2^i & x_1^i \\
	0 & 0 & 0 & -x_2^i & -y_2^i & -1 & y_1^ix_2^i & y_1^iy_2^i & y_1^i
\end{bmatrix}
	\begin{bmatrix}
		h_1 \\ h_2 \\ h_3 \\ h_4 \\ h_5 \\ h_6 \\ h_7 \\ h_8 \\ h_9
	\end{bmatrix} = \vec{0}\\
\therefore \vec{A}_i =
	\begin{bmatrix}
        -x_2^i & -y_2^i & -1 & 0 & 0 & 0 & x_1^ix_2^i & x_1^iy_2^i & x_1^i \\
        0 & 0 & 0 & -x_2^i & -y_2^i & -1 & y_1^ix_2^i & y_1^iy_2^i & y_1^i
    \end{bmatrix}
$$

### 4.

The trivial solution of $\mathbf{h}$ is $\mathbf{0}$.

**(I don't know)**

# Q2.1

## Q2.1.4

![](/home/daniel/Documents/projects/COMP4901L/assgn2_no_cv_package/saved_figures/2_1_4.png)

## Q2.1.5

![](/home/daniel/Documents/projects/COMP4901L/assgn2_no_cv_package/saved_figures/2_1_5_0.png)

![](/home/daniel/Documents/projects/COMP4901L/assgn2_no_cv_package/saved_figures/2_1_5_1.png)

![](/home/daniel/Documents/projects/COMP4901L/assgn2_no_cv_package/saved_figures/2_1_5_2.png)

![](/home/daniel/Documents/projects/COMP4901L/assgn2_no_cv_package/saved_figures/2_1_5_3.png)

There is a clear correlation between the rotation difference of the images and the decrease in point correspondences. The reason for this is BRIEF creates a representation of a spacial patch around the target points using random (x, y) pairs intensity comparisons and compare these representations to some targets, thus they are sensitive to rotations since the larger the differences, the more difference there will be in the (x, y) pair insensity comparisons. So for instance, a plain dot will not be much affected by the rotation, but areas where patches containing multiple features, will be penalized by the algorithm.