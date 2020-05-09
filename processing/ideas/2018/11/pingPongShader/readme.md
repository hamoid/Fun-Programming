# pingPongShader

In this sketch I apply horizontal blur and vertical blur multiple times.

It uses something called ping pong buffers. Basically: I draw on buffer A,
then draw a horizontally blurred version to buffer B, then draw that one
blurred vertically back on buffer A, draw some more stuff on it and repeat.

I blur R, G and B channels slightly differently to produce some kind of
chromatic aberration.

Having sharp and blurred objects creates depth.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2018/11/pingPongShader/thumb.png)

