# measureDroppedFrames

An attempt to measure dropped frames. At 60 frames per second we have 16.666 milliseconds to draw everything to our canvas.
If it takes longer than that we will be late and the graphics will only make it to the next frame.

With something moving on the screen at constant speed it becomes obvious and disturbing if an animation frame is missing.
It feels like a sudden jump.

What I measure in this program is how often draw() gets called, which is not the same as dropped frames. Even if often
it takes more than 17 milliseconds for draw() to be called again, there's no visible jump in the screen.

The jumps become obvious when that delay goes about 20 milliseconds.

There seems to be a big drop in my system always at 45 seconds after starting the program.

In Java2D the frequency is much more irregular than in P2D / P3D.

Interacting with any other application while the program runs produces timing irregularities. I have not noticed this
in openFrameworks. The animation often feels smoother in the C++ based framework.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2018/10/measureDroppedFrames/thumb.png)

