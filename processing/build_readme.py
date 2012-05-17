import os, os.path, subprocess


execstr = "git ls-files ./ | grep -E '.pde|.scd'"
result = subprocess.check_output(execstr, shell=True).split('\n')

currDir = os.getcwd().split('/')[-1]

f = open('readme.md', "w")
for line in result:
  if line:
    f.write('[%s](%s/%s)\n' % (os.path.basename(line), currDir, line))
f.close()

