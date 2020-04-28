# shaderScrollTextured

A confusing program doing a lot of stuff :) To start press `[space]`.

There's video playing as a source of texture.
It uses noise to draw that texture in symmetrical "butterfly like" shapes.

It uses a flow-style shader to smear the result based on hue. 

Then the whole result is partially occluded and seen only through 
a mask full of words. That mask is loaded
from disk, but there's an alternative one generated in real time (commented out).
The mask scrolls up as the credits of a movie.

The `[enter]` key jumps to a random location in the movie and randomizes noise seed.

The `s` key is used for starting and ending video export. It calls a command line
voice synthesizer to speak `start` and `stop`.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2018/02/shaderScrollTextured/thumb.jpg)

