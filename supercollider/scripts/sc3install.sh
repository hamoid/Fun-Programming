# SuperCollider Ubuntu installer script


# ------------------- Disclaimer ----------------------
# Use this script at your own risk!
# I'm not responsible if it eats your computer.


# --------------------- About -------------------------
# Installing programs in Ubuntu is very easy when using
# the Ubuntu Software Center. Unfortunately not every
# program can be found there. SuperCollider is one of
# those programs.

# With this script I try to make it easier to try out
# SuperCollider 3.5.1 on Ubuntu, for those who are
# not used to the command line.


# ------------------- Installation --------------------
# In three words: run this script :)
# In more words:

# 1. Select and copy the next line (every character from wget until the end of the line)
#    wget https://raw.github.com/hamoid/Fun-Programming/master/supercollider/scripts/sc3install.sh; bash sc3install.sh
# 2. Press Ctrl+Alt+T to open a terminal.
# 3. Press Ctrl+Shift+V to paste (not Ctrl+V!) and press ENTER.

# 4. You will be asked if you want to install SuperCollider.
#    Type y if it's not yet installed and press ENTER.
# 5. Enter your password when asked.

# 6. You may get asked about activating Jack's realtime priority.
#    If find changing Ubuntu settings complicated, type n and press ENTER.

# 7. You will be asked if you want to install the gedit 3 plugin.
#    Type y if it's not yet installed and press ENTER.

# 8. When done installing, close the terminal and open the gedit application.
# 9. Go to the edit > preferences > plugins menu.
# 10. Activate the SuperCollider plugin, then click close.
# 11. Go to the tools menu and choose SuperCollider Mode.

# 12. In gedit, type:
#     Server.default = s = Server.internal.boot
# 13. Press Ctrl+E to evaluate that line, then press ENTER to go to the next line.
# 14. Lower the volume of your speakers or headphones and type:
#     { SinOsc.ar(80) }.play
# 15. Press Ctrl+E to evaluate that line. Press ESC to stop the sound.


# ----------------- SuperCollider links ---------------------
# Help:                     http://doc.sccode.org/
# More help:                http://help.sccode.org/
# Forum:                    http://bit.ly/sc-forum
# Jack's realtime priority: http://bit.ly/jack-rt-prio


# ------------------ Finally, the script ---------------------
# The next steps were copied from:
# https://scacinto.wordpress.com/2011/02/08/supercollider-on-ubuntu/
# https://launchpad.net/~supercollider/+archive/ppa

echo ""
read -p "Add PPA keys and install SuperCollider (y/n)? Choose no if already installed. " answer

echo "Installing 1/4"
[[ $answer =~ ^([yY])$ ]] && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FABAEF95

echo "Installing 2/4"
[[ $answer =~ ^([yY])$ ]] && sudo add-apt-repository ppa:supercollider/ppa

echo "Installing 3/4"
[[ $answer =~ ^([yY])$ ]] && sudo apt-get update

echo "Installing 4/4"
[[ $answer =~ ^([yY])$ ]] && sudo apt-get install supercollider-common supercollider-server libscsynth1 supercollider



# This part I wrote myself. It downloads the gedit 3 plugin
# which is currently missing from the Launchpad package.

echo ""
read -p "Dowload SuperCollider gedit 3 plugin (y/n)? " answer

# Make a folder inside your home folder where to store the gedit plugin
[[ $answer =~ ^([yY])$ ]] && mkdir -p ~/.local/share/gedit/plugins

# These two files go inside the folder we just created
[[ $answer =~ ^([yY])$ ]] && wget -O ~/.local/share/gedit/plugins/supercollider.plugin "https://raw.github.com/supercollider-team/supercollider/master/editors/sced/sced3/supercollider.plugin.in"
[[ $answer =~ ^([yY])$ ]] && wget -O ~/.local/share/gedit/plugins/supercollider.py "https://raw.github.com/supercollider-team/supercollider/master/editors/sced/sced3/supercollider.py"

# These will ask for your password, because the files are written to /usr/share/
[[ $answer =~ ^([yY])$ ]] && sudo wget -O /usr/share/gtksourceview-3.0/language-specs/supercollider.lang "https://raw.github.com/supercollider-team/supercollider/master/editors/sced/data/supercollider.lang"
[[ $answer =~ ^([yY])$ ]] && sudo wget -O /usr/share/mime/packages/supercollider.xml "https://raw.github.com/supercollider-team/supercollider/master/editors/sced/data/supercollider.xml"

echo ""
echo "I hope it worked out!"
echo ""