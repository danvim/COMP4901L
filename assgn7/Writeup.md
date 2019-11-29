# COMP4901L Assignment7 Writeup

>WONG Yuk Chun (ycwongal, 20419764)
>
>CHEUNG Daniel (dcheungaa, 20423088)

## Part 1

## Q1

$$
\let\vec\mathbf
\text{Assuming}\\

\vec{W}(\vec{x};\vec{p})=\begin{bmatrix}
\vec{W}_x\\ \vec{W}_y\\ \vec{W}_1
\end{bmatrix}\begin{bmatrix}
x\\y\\1
\end{bmatrix}=\begin{bmatrix}
1+p_1&		p_3&		p_5\\
p_2&		1+p_4&		p_6\\
0&			0&			1
\end{bmatrix}\begin{bmatrix}
x\\y\\1
\end{bmatrix}\\

\text{and,}\\

\vec{p}=\begin{bmatrix}p_1&p_2&p_3&p_4&p_5&p_6\end{bmatrix}^T\\
$$

$$
\begin{align}
\vec{J}&=\frac{\part\vec{W}}{\part\vec{p}}\\
&=\begin{bmatrix}
\frac{\part\vec{W}_x}{\part\vec{p}_1}& \dots& \frac{\part\vec{W}_x}{\part\vec{p}_6}\\
\frac{\part\vec{W}_y}{\part\vec{p}_1}& \dots& \frac{\part\vec{W}_y}{\part\vec{p}_6}\\
\end{bmatrix}\\
&=\begin{bmatrix}
x&	0&	y&	0&	1&	0\\
0&	x&	0&	y&	0&	1
\end{bmatrix}
\end{align}
$$

