mkdir -p ~/.local/share/gedit/plugins

wget -O ~/.local/share/gedit/plugins/supercollider.plugin "http://supercollider.git.sourceforge.net/git/gitweb.cgi?p=supercollider/supercollider;a=blob_plain;f=editors/sced/sced3/supercollider.plugin.in;hb=HEAD"

wget -O ~/.local/share/gedit/plugins/supercollider.py "http://supercollider.git.sourceforge.net/git/gitweb.cgi?p=supercollider/supercollider;a=blob_plain;f=editors/sced/sced3/supercollider.py;hb=HEAD"

sudo wget -O /usr/share/gtksourceview-3.0/language-specs/supercollider.lang "http://supercollider.git.sourceforge.net/git/gitweb.cgi?p=supercollider/supercollider;a=blob_plain;f=editors/sced/data/supercollider.lang;hb=HEAD"

sudo wget -O /usr/share/mime/packages/supercollider.xml "http://supercollider.git.sourceforge.net/git/gitweb.cgi?p=supercollider/supercollider;a=blob_plain;f=editors/sced/data/supercollider.xml;hb=HEAD"
