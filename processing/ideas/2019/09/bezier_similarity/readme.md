# bezier_similarity

I mildly interactive sketch. The mouseX position sets the length of the drawn lines.
[space] clears the background.

Lines are drawn starting on a circle, the exact point advancing clockwise. For each line
it searches for 3 other nearby points at 3 different distances. It does that by first
checking the pixel color on a photo at the spawn location. Then it searches three
concentric circles in that photo for the most similar color in that virtual circle.

The spawn point and the 3 found points for the basis for a bezier curve. Instead of
drawing that bezier curve directly, it interpolates smoothly towards that bezier curve.
It does so to avoid jitter and reduce random jumps.

By coming up with different algorithms for moving the spawn point one can produce
different aesthetics.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2019/09/bezier_similarity/thumb.png)

