Server.default = s = Server.internal.boot;

(
    n = NetAddr("127.0.0.1", 10000); 
    
    c = MIDIFunc.cc({
        arg ...a; 
        n.sendMsg("/cc",   a[0], a[1]); 
    }); // a[0] = val; a[1] = control#;
)

n.disconnect;
