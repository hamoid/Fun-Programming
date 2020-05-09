# caustic

Trying to simulate the light at the bottom of the swimming pool.

I treat the the `noise()` value of locations on the screen as their
elevation (the elevation of the water moving up and down).

The difference in elevation of a location and the surrounding locations
gives the inclination of the water at that point. This inclination
refracts the light of ray in certain direction, increasing the brightness
at that point.

Slow. Non real-time. A shader could easily do this in real time.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2016/02/caustic/thumb.jpg)

