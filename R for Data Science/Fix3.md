>1. It is unclear why in section "Guided Part: 3:" you used a linear regression to test the homoscedascity (I.E. homogeneity of variance) for the correlation analysis. I am not familiar with this approach -- and I think it might be specifically related to regression analysis and not necessarily for correlation.

The regression there just helps with the visualization (determining the degree of zooming and rotation) since a residuals vs fitted plot isn't but a zoomed and
rotated scatterplot. The relative position of the points remains the same as in the scatterplot.

>It is also not clear why you argue that "Variance is clearly greater as values grow, so the data is clearly not homoscedastic." That was definitely not my interpretation of the residuals vs fitted plot -- so I think this statement needs more explanation and support.

There may be other things that can be deduced from the plot (such as lack of linearity) but I think non-homogeneity of variance is one of them: the leftmost part,
which comprises most observations, is cone-shaped.

>Some lines of code are too long and this hurts readability. I will clarify more what the problem is I am trying to indicate.

Excessively long lines were split (this was only appplied to code lines, since markdown content is expected to be read after knitting)
