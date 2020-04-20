# gradientWithVertex

Draw a grid of rectangles covering the screen
and maintaining a margin between rectangles and the borders of the window.

The recangles are filled with a gradient and also have a gradient stroke.
This is achieved by setting the fill and stroke colors before each call to `vertex()`.

A better approach to gradients is by using shaders, as this technique does not allow
rotating the gradient and is heavily influenced by the number of vertices and their order.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2019/04/gradientWithVertex/thumb.jpg)

