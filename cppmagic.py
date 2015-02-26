#
# cppmagic.py
#

import IPython.core.magic as ipym
import os

@ipym.magics_class
class CppMagics(ipym.Magics):

  @ipym.cell_magic
  def cpp(self, line, cell=None):

    src = os.path.abspath('tmp.cpp')
    prog = os.path.abspath('tmp.exe')

    with open(src, 'w') as f:
      f.write(cell)

    CXX = "g++"
    CFLAGS = "-Wall"

    cmd = "%s %s %s -o %s" % (CXX, CFLAGS, src, prog)

    compile = self.shell.getoutput(cmd)   
    output  = self.shell.getoutput(prog)

    return output


def load_ipython_extension(ipython):
  ipython.register_magics(CppMagics)


  
