# COMP4901L Assignment6 Writeup

>WONG Yuk Chun (ycwongal, 20419764)
>
>CHEUNG Daniel (dcheungaa, 20423088)

## Part 4

Accuracy: 0.974

confusion matrix:

```
51    0     0     0     0     0     0     0     0     0
0    52     1     0     0     0     0     0     0     0
0     0    41     1     0     0     0     0     1     0
0     0     0    61     0     1     0     1     1     0
0     0     0     0    46     0     1     1     0     0
0     0     0     0     0    45     0     1     0     0
0     0     0     0     0     0    41     0     0     0
0     0     0     0     0     0     0    47     0     2
0     0     0     1     0     0     0     0    59     0
0     0     0     0     0     0     0     1     0    44
```

7 and 9 are the most easily confused digit. If we sqeueeze the loop of 9, it looks like 7. Or in some style of 7 there is verticle stroke at top left and horizontal line in middle and we intersect both line, it looks like 9.

3 and 8 are also easily confused. If the start and end of 3 is closer to the middle, it looks like 8.

