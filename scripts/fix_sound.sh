#!/bin/bash
# Bash script to fix sound in Processing for Ubuntu

# Tested only in Ubuntu 12.04 and 13.04!

# 1) open a terminal 
#    CTRL+ALT+T
# 2) cd into the folder that contains the processing folder. 
#    If you have /home/MYUSER/Desktop/MYP5/processing-2.0/ then type:
#    cd /home/MYUSER/Desktop/MYP5/
# 3) Download this script:
#    wget https://raw.github.com/hamoid/Fun-Programming/master/scripts/fix_sound.sh
# 4) Make the script executable:
#    chmod +x fix_sounds.sh
# 5) run the script (it will ask for your password). The argument is the P5 folder name.
#    ./fix_sound.sh processing-2.0
# 6) Enjoy sound :)

# Feel free to fork, fix and improve :)

# Details about the issue: http://code.google.com/p/processing/issues/detail?id=930

# By Abe Pazos - http://funprogramming.org

echo

uname -m|grep -q 64
if [ $? -eq 0 ] 
then
        P2="/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/"
        P3="/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/"
        F2="amd64/libpulse-java.so"
else
        P2="/usr/lib/jvm/java-6-openjdk-i386/jre/lib/"
        P3="/usr/lib/jvm/java-6-openjdk-i386/jre/lib/"
        F2="i386/libpulse-java.so"
fi

P1="/usr/lib/jvm/java-6-openjdk-common/jre/lib/"

F1="ext/pulse-java.jar"
F3="sound.properties"

if [ ! -f $P1$F1 ]
then
    echo "$(P1)$(F1) not found!"
    exit 1
fi

if [ ! -f $P2$F2 ]
then
    echo "$(P2)$(F2) not found!"
    exit 1
fi

if [ ! -f $P3$F3 ]
then
    echo "$(P3)$(F3) not found!"
    exit 1
fi

if [ $# -ne 1 ]
then
    echo "Please use: fix_sound.sh [PATH_THAT_CONTAINS_PROCESSING_FOLDER]"
    echo "For instance: fix_sound.sh ./processing-2.0.2"
    exit 1
fi

echo "All files found. Good :)"

set -e

TARGET="$1/java/lib/"

sudo cp $P1$F1 $TARGET$F1
sudo cp $P2$F2 $TARGET$F2
sudo cp $P3$F3 $TARGET$F3

sudo chown $whoami:$whoami $TARGET$F1
sudo chown $whoami:$whoami $TARGET$F2
sudo chown $whoami:$whoami $TARGET$F3
sudo chmod +x $TARGET$F2

echo
echo "These files were copied:"
ls -la $TARGET$F1
ls -la $TARGET$F2
ls -la $TARGET$F3

echo
echo "I hope sound now works in Processing! :)"
echo

