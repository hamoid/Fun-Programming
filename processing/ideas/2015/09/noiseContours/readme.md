# noiseContours

Creates a noise based quantized image, sort of an elevation-map in black and white.
Then applies openCV contours to that image to get vector outlines of the shapes.
It sorts them by size to first draw the larger ones, then the smaller ones
(otherwise small ones would be occluded by larger ones).

Uses the openCV library from 
https://github.com/cansik/opencv-processing/releases
as the official one is not working (April 14th, 2020)


![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2015/09/noiseContours/thumb.png)

