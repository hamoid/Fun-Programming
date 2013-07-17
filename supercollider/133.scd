
(
{
    f = SinOsc.kr([10.rand, 10.rand], 0, 90.rand, 100.rrand(500));

    v = SinOsc.kr(1.0.rand, 0, 0.5, 0.5) *
    SinOsc.kr(1.0.rand, 0, 0.5, 0.5) *
    SinOsc.kr(1.0.rand, 0, 0.5, 0.5);

    SinOsc.ar(f, 0, v / 100)
}.play;
)

// 44100 48000
// 100

{ SinOsc.ar(440, 0, 1, 0) }.play;