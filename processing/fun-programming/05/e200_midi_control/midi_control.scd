Server.default = s = Server.internal.boot;

(
    n = NetAddr("127.0.0.1", 10000); 
    
    a = MIDIFunc.noteOn({
        arg ...a; 
        n.sendMsg("/note", a[0], a[1]); 
    }); // a[0] = velo; a[1] = note#;
    
    b = MIDIFunc.noteOff({ 
        arg ...a; 
        n.sendMsg("/note", a[0], a[1]); 
    }); // a[0] = velo; a[1] = note#;
    
    c = MIDIFunc.cc({
        arg ...a; 
        n.sendMsg("/cc",   a[0], a[1]); 
    }); // a[0] = val; a[1] = control#;
)
n.disconnect;

