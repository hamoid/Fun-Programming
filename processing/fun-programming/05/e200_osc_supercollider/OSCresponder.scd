
(
    ~playSound = { 
        ~thesynth = Synth("default"); 
    };
    ~stopSound = { 
        ~thesynth.set("gate", 0); 
    };

    ~r1 = OSCresponder(nil, '/playit', ~playSound).add;
    ~r2 = OSCresponder(nil, '/stopit', ~stopSound).add;
)

(
    ~r1.remove;
    ~r2.remove;
)


