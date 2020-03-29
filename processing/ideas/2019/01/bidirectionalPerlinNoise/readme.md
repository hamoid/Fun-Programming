# bidirectionalPerlinNoise

Noise field. A typical effect is sampling a noise field by using the current 
pixel coordinates then interpreting the obtained value as an angle to move
to a nearby pixel, and keep repeating that operation. The resulting image
resembles somewhat roots or branches: lines that converge.

In this case I repeat the process twice, the second time inverting the
displacement sign. So for the starting point I obtain two lines instead of
one, and they go in exactly opposing directions. The difference is that
it looks less like branches or roots because one can not see the beginning
of those brances or roots. It's like connecting the branches of two trees
together, each branch connecting with a branch in the other tree.

Try changing the sigmoid value between 0.0 and 1.0 for different looks.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2019/01/bidirectionalPerlinNoise/thumb.jpg)

