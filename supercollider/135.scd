(
e = Env.linen(0.1, 0.2, 2, 0.2);
f = 5.rand * 40 + 50 + 5.0.rand;
{ SinOsc.ar([f, f+5], 0, EnvGen.kr(e, doneAction:2)) }.play
)

