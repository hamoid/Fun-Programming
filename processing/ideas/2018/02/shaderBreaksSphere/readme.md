# shaderBreaksSphere

The sketch uses the sphere purely as data ignoring all matrices (therefore the camera doesn't work).
The vertex shader calculates a new position of each vertex based on sines and cosines of
the original vertex coordinates.

It also shows how to directly use gl_Position to place things
in the window.

It makes use of a ShaderReloader class, based on code by Raphaël de Courville.
That class shows an error overlay message when the shader
does not compile.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2018/02/sphere/thumb.jpg)

