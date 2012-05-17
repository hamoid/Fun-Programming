import os.path, subprocess


execstr = "git ls-files ./ | grep -E '.pde|.scd'"
result = subprocess.check_output(execstr, shell=True).split('\n')

f = open('readme.md', "w")
for line in result:
  if line:
    f.write('[%s](%s)\n' % (os.path.basename(line), line))
f.close()
