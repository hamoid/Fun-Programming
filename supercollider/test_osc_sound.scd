// 1. Create a network address pointing to your own computer.
~myself = NetAddr("127.0.0.1", NetAddr.langPort);

// 2. Create a function that will run when receiving messages.
(
~msgReceived = { |msg, time, addr, port| 
    "Got it!".postln; 
    msg.postln; 
    f = 200.rand + 200;
    { SinOsc.ar([f, f+2]) * 0.1 * EnvGen.kr(Env.perc(), doneAction: 2) }.play;
};
)

// 3. Start listening to messages coming from your own computer.
// If you change ~msgReceived after running this line, you have to
//run o.free, and then evaluate this line again.
o = OSCFunc(~msgReceived, '/hello', ~myself);

// 4. Send a message to yourself. It should print on the output window
// and play a sound. You can send this message from here, or 
// send /msg from Processing to 127.0.0.1, port 57120
~myself.sendMsg("/hello", "Hello", "world!");

// 5. Stop listening to the OSC message
o.free

