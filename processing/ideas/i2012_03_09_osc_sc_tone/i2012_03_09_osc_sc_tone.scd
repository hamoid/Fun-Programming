// Example program to control audio on real time from Processing.
// Processing is sending the mouse x and y values 10 times per second
// inside an OSC message to SuperCollider.

// Start the internal SuperCollider server
Server.default = s = Server.internal.boot

(
    // We will use a bus to send changes to a running synth.
    b = Bus.control(s, 2);
    // Set default pitch and volume.
    b.set(440, 0.3);

    // Create a synth definition
    SynthDef(\p55synth, {
        // The frequency and volume values come from a global bus with two channels called b. 
        // lag() smoothes the values out. Try without lag() to see the difference.
        // lag() is used because Processing is sending new values only at 10 frames per second.
        var freq = b.kr(1, 0).lag(0.3); 
        var vol = b.kr(1, 1).lag(0.3);
	    Out.ar(0, SinOsc.ar(freq, 0, vol));
    }).load(s);

    // This makes SuperCollider listen to OSC messages coming from Processing.
    // Don't evaluate this more than once without using the clean up below.
    // Otherwise you will have several overlapping OSC responders.
    r = OSCresponderNode(nil, '/pitchvol', { arg time, resp, msg; 
        b.set(msg[1], msg[2]);
    }).add;

    // Make the synth play.
    Synth(\p55synth);
)
(
    // Clean up
    r.remove;
    b.free;
)
