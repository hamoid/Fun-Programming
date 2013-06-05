# Bash script to fix sound in Processing for Ubuntu

# Tested only in Ubuntu 12.04!

# 1) open a terminal 
#    CTRL+ALT+T
# 2) cd into the folder that contains the processing folder. 
#    If you have /home/MYUSER/Desktop/MYP5/processing-2.0b9/ then type:
#    cd /home/MYUSER/Desktop/MYP5/
# 3) run the script (it will ask for your password):
#    ./fix_sound.sh processing-2.0b9
# 4) Enjoy sound :)

# Feel free to fork, fix and improve :)

# By Abe Pazos - http://funprogramming.org

set -e

echo

P1="/usr/lib/jvm/java-6-openjdk-common/jre/lib/"
P2="/usr/lib/jvm/java-6-openjdk-i386/jre/lib/"
P3="/usr/lib/jvm/java-6-openjdk-i386/jre/lib/"

F1="ext/pulse-java.jar"
F2="i386/libpulse-java.so"
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

if [ ! -d $1 ]
then
    echo "Please use: fix_sound.sh [PATH_THAT_CONTAINS_PROCESSING_FOLDER]"
    echo "For instance: fix_sound.sh ./processing-2.0b9"
    exit 1
fi

echo "All files found. Good :)"

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

