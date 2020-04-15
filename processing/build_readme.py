# This Python script finds recursively all
# Processing and SuperCollider programs
# under the current directory that have
# been added to Git, then saves the
# resulting list to the file "readme.md",
# which GitHub uses as a read me file.

import os, os.path, subprocess, re

columns = 5

execstr = "git ls-files ./ | grep -E '.pde|.scd'"
result = subprocess.check_output(execstr, shell=True).split('\n')

absolutePath = 'https://github.com/hamoid/Fun-Programming/blob/master/processing'

f = open('readme.md', "w")

f.write(('| . ' * columns) + '|\n')
f.write(('| --- ' * columns) + '|\n')

col = 0

for line in result:
  if line:
   
    sketchName = os.path.splitext(os.path.basename(line))[0]
    ideaFolder = os.path.dirname(line)
    
    if line.endswith('.pde'):
      if sketchName not in ideaFolder.split('/'):
        continue

    thumb = ""
    if not os.path.exists(ideaFolder + '/.thumb.jpg'):
      if os.path.exists(ideaFolder + '/thumb.png'):
        os.system('imgToSquare.fish %s/thumb.png 150 %s/.thumb.jpg' % (ideaFolder, ideaFolder))
        os.system('git add -f %s/thumb.png' % ideaFolder)
      if os.path.exists(ideaFolder + '/thumb.jpg'):
        os.system('imgToSquare.fish %s/thumb.jpg 150 %s/.thumb.jpg' % (ideaFolder, ideaFolder))
        os.system('git add -f %s/thumb.jpg' % ideaFolder)

    if os.path.exists(ideaFolder + '/.thumb.jpg'):
      t = '%s/.thumb.jpg' % ideaFolder
      thumb = '<br>![](%s)' % t
      os.system('git add -f %s' % t)
      print(t)

    sketchName = re.sub("([a-z])([A-Z])","\g<1> \g<2>", sketchName.replace('_', ' '))

    f.write('| [%s%s](%s/%s/) ' % (sketchName, thumb, absolutePath, ideaFolder))
    
    if col % columns == (columns - 1):
      f.write(' |\n')
      
    col = col + 1
    
f.close()

os.system('git add readme.md')

