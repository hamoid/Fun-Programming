# orthocubes

Creates a cloud of cuboids positioned and scaled using `noise()`.
The cuboids are shaded with a shader that produces stripes along
one axis. The axis is specified as a integer `uniform` between 0 and 2 
for each drawn cuboid. You can access a component of a vec3 in a
shader by its index, so `pos[0] = pos.x`, `pos[1] = pos.y` and
`pos[2] = pos.z`.

Hold down the mouse button to see the effect of `OPTIMIZED_STROKE`.
For me the default state of that property in Processing is not 
the expected one, as `OPTIMIZED_STROKE`
produces unwanted side effects when using vertex shaders.
If something is not working with your vertex shader I suggest
toggling that variable to `ENABLED` and `DISABLED` to see if it
has an effect.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2018/04/orthocubes/thumb.jpg)

