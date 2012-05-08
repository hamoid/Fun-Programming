# gedit 3 SuperCollider plugin downloader

# Tested on Ubuntu 11.10
# May 8th, 2012

# The SuperCollider 3.5.1 package found at
# https://launchpad.net/~supercollider/+archive/ppa
# does not currently include the gedit plugin.

# This script downloads the missing plugin directly 
# from GitHub.

# Make a folder inside your home folder where to store the gedit plugin
mkdir -p ~/.local/share/gedit/plugins

# These two files go inside the folder we just created
wget -O ~/.local/share/gedit/plugins/supercollider.plugin "https://raw.github.com/supercollider-team/supercollider/master/editors/sced/sced3/supercollider.plugin.in"
wget -O ~/.local/share/gedit/plugins/supercollider.py "https://raw.github.com/supercollider-team/supercollider/master/editors/sced/sced3/supercollider.py"

# These will ask for your password, because the files are written to /usr/share/
sudo wget -O /usr/share/gtksourceview-3.0/language-specs/supercollider.lang "https://raw.github.com/supercollider-team/supercollider/master/editors/sced/data/supercollider.lang"
sudo wget -O /usr/share/mime/packages/supercollider.xml "https://raw.github.com/supercollider-team/supercollider/master/editors/sced/data/supercollider.xml"
