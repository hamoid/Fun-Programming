# lacunaNoiseLogo

Animated cow texture using value noise. There was a time when we opened
Lacuna Lab we wanted to have animated logos in the home page.
This was an experiment that went nowhere :)

Maybe interesting to point out is the third argument used in noise.
It could be only `frameCount * 0.01` but that produces an ugly rythmical
pattern typical in the noise in Processing, so what I did was to offset that
time by the distance to the center of the screen. This avoids all pixels 
pausing simultaneously and create some kind of unnoticeable pause-wave instead.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2015/06/lacunaNoiseLogo/thumb.png)

