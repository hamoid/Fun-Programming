// Show net values to use in Processing
NetAddr.localAddr

(
SynthDef(\shortSynth, {
    arg pitch=200;
    var sound = SinOsc.ar(pitch * 2, mul:0.3);
    var linen = Env.linen(0.01, sustainTime:0, releaseTime:0.3);
    var env = EnvGen.kr(linen, doneAction:2);
    Out.ar(0, sound * env);
}).add;
)

(
SynthDef(\foreverSynth, {
    arg pitch = 200;
    var lfo = SinOsc.kr(2, 0, 5);
    // 0.1 seconds portamento, tweens the missing
    // values smoothly
    var portaPitch = Lag.kr(pitch, 0.1);
    var sound = LFTri.ar(portaPitch + lfo, mul:0.1);
    Out.ar(0, sound);
}).add;
)



// A sound that plays forever
~long = Synth(\foreverSynth);

// test modifying the pitch to see it works
~long.set(\pitch, 200.rrand(1000));

(
// Listen to OSC messages
OSCdef('processing', {
    arg msg;

    // value received from Processing
    var pval = msg[1];

    // debug: show value
    //msg[1].postln;

    // Now we can do different things, like:

    // Option 1. start a new Synth for each OSC msg
    Synth(\shortSynth, [pitch:msg[1]]);

    // Option 2. modify an existing Synth for each OSC msg
    ~long.set(\pitch, msg[1]);
}, "/length");
)

