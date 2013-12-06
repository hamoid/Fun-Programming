// The port Processing is listening to
n = NetAddr("127.0.0.1", 12000);

(
// A simple synth
SynthDef(\testSound, {
    arg freq, amp;
    var mysound, envelope;
    mysound = SinOsc.ar([freq, freq*2]);
    envelope = EnvGen.kr(Env.perc, doneAction:2);
    Out.ar(0, mysound * envelope * amp);
}).add;
)

(
// Listen to the events from my sequencer
Event.addEventType(\soundAndGfx, {
    // Play a sound
    Synth(\testSound, [freq: ~freq, amp: ~amp]);
    // Tell Processing to visualize my sound
    n.sendMsg("/testSound", ~freq, ~amp);
});

// My simple sequencer with some random
// frequencies and amplitudes
p = Pbind(
    \type, \soundAndGfx,
    \freq, Prand([40, 50, 70, 72, 42, 89], inf),
    \amp, Prand([0.1, 0.2, 0.3, 0.4], inf),
    \dur, 0.2
).play;
)
