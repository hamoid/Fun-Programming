# spline

Attempt to create a keyframe animation system with smooth transitions.
 
This version correctly passes keyframe locations at
the right time, but there is an abrupt speed 
change when passing keyframes if the duration of 
the last and the next segment greatly differs.

I tried calculating the segment density (hack, I know)
and then adjusting the control point distances to
try to counteract the sudden speed changes. Not good :)

Next attempt should use Catmull-Rom spline curves.

Ideas: create Timeline class that contains Segment objects,
current segment, current Timeline-time, Segment-time.

![](https://raw.githubusercontent.com/hamoid/Fun-Programming/master/processing/ideas/2012/04/spline/thumb.jpg)

