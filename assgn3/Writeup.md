# COMP4901L Assignment3 Writeup

>WONG Yuk Chun (ycwongal, 20419764)
>
>CHEUNG Daniel (dcheungaa, 20423088)

## 2.1. Triangulation

$$
\gamma = \pi - \alpha - \beta\\
\frac{\sin\gamma}{b} = \frac{\sin\alpha}{d}\\
d=\frac{b\sin\alpha}{\sin(\pi-\alpha-\beta)}=\frac{b\sin\alpha}{\sin(\alpha+\beta)}\\
x=d\cos\beta=\frac{b\sin\alpha\cos\beta}{\sin(\alpha+\beta)}=\frac{b}{\cos\alpha\sin\beta}\\
y=d\sin\beta=\frac{b\sin\alpha\sin\beta}{\sin(\alpha+\beta)}
$$

## 2.2. Fundamental Matrix

When a point $\vec X$ in 3D is mapped to $\vec x$ in image 1 and $\vec y$ in image 2, the fundamental matrix shall satisfy the following property
$$
\vec x^T F\vec y = 0
$$
Since the principle point is mapped to origin of both images, we have
$$
\begin{aligned}
\begin{bmatrix}0&0&1\end{bmatrix}\begin{bmatrix}a&b&c\\d&e&f\\g&h&i\end{bmatrix}\begin{bmatrix}0\\0\\1\end{bmatrix} = 0\\
\begin{bmatrix}0&0&1\end{bmatrix}\begin{bmatrix}c\\f\\i\end{bmatrix} = 0\\
i=0
\end{aligned}
$$
Which implies the $F_{3,3}$ element of the fundamental matrix $F$ is 0