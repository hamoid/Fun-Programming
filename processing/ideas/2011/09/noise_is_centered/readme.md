# noise_is_centered

The blue line shows that noise spends most of the time
at the center (near the value 0.5). 
Rarely, if ever, it will go to the top or to the bottom.

This is an attempt to fix that.
We modify the noise value (n) in a way that the
whole range of values is covered: from 0 to 1.

One drawback with this formula is that it's not
continuous. It can disappear on the top and then
appear on the bottom.

The red line shows the modified noise value.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2011/09/noise_is_centered/thumb.jpg)
