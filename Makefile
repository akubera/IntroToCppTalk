#
# Makefile
#

PYVENV ?= pyvenv-3.4

.PHONY: all env use run

all: env

env: pyvenv.cfg

pyvenv.cfg:
	${PYVENV} --system-site-packages --symlinks .

use:
	@echo "Cannot be done from make. Run this code in terminal:"
	@echo "source bin/activate"

run:
	ipython notebook
