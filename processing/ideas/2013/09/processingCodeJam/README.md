Processing Code Jam - Open Tech School Berlin

07.09.2013

One of the topics of today is P2P P5 (Peer to peer Processing).

We use a library called OscP5 to communicate computers with each other.
You can install it by opening the Processing IDE, then go to
Sketch > Import Library > Add Library > OscP5 > Install

The goal is to have each of us write a program that listens to the mice
and keyboards of all other participants in the room. One by one we will
connect our laptops to the proyector, our processing program will 
listen to the input coming from all other computers and our program will
do something with that input. We could build a collaborative drawing program,
a chat program, a multiplayer game, or something else.

To help with the development, I will provide here examples that provide the
OSC communication that connects different Processing sketches running in
different computers.

You can download the sample source from
https://github.com/hamoid/balconylab/
or as a zip file from:
https://github.com/hamoid/balconylab/archive/master.zip

There you will find several programs:

twoMice

    The initial test that inspired today's concep. Ramin and I wrote this program.
    It's a drawing program for two. You run it in two laptops, and both laptops
    show the drawing being made by both users.

MouseKeySender

    Program that sends key and mouse data to the Receiver. This will be run by
    every user except the presenter.

MouseKeyTestSender

    Program to replace MouseKeySender, which simulates several users using the
    mouse and the keyboard. It's used for testing several users on your own
    computer.

MouseKeyReceiver

    First version for the presenter. This program listens to multiple Senders. 
    It uses a non-very elegant approach, as you must read all data sent by the
    Senders in a loop.

MouseKeyReceiver2

    Second version for the presenter. More elegant than MouseKeyReceiver. It
    allows you to loop through all Senders, and read their properties.

To do:

    Build methods that allow detecting events like keyPressed and mousePressed.
    Currently you only have access to the last values sent, but you don't
    know when those values got set. Events are important for games or interaction.


