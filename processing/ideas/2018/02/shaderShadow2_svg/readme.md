# shaderShadow2_svg

Loads an svg into a PShape, then draws that 255 times in 
various locations on the screen using a gray scale fill color.

That fill color represents depth and it's used by the shader
to know where to draw drop shadows. The shader colorizes each
shape using a cosine based palette generator.

This is not necessarily a good idea :) It's just an experiment.

Limited to 255 objects (as buffers in Processing are not
floating point based).

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2018/02/shaderShadow2_svg/thumb.png)

