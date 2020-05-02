# we

Draw a grid by drawing a set of vertical and horizontal lines.
Those lines are distorted by using noise.
The lines are actually drawn with blend mode ADD in 3 passes,
one for red, one for green and one for blue. Each of those passes
is slightly offset in the noise space, producing chromatic aberration.

A black and white image is generated with the word "we". Later the pixels
of that image are sampled to decide how bright the R, G and B colors
should be, making the word appear in the rendered grid.

Press the `[space]` key to try again with a different seed.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2015/06/we/thumb.jpg)

