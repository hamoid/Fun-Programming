# random_vs_noise

This program studies what happens when you use `noise()` or `random()`
to define the hue component of a color.
 
`random()` covers the whole spectrum and you get all kinds of hues.
 
`noise()` does not cover the whole spectrum. Reds, oranges and yellows are missing.
 
`snoise()`, a custom function, tries to improve this by stretching the `noise()`
values. But red is still missing.
 
`anoise()` wraps values around `noise()` 10 times to avoid bias towards one color

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2012/04/random_vs_noise/thumb.jpg)

