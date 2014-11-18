#
# Makefile
#

PYVENV ?= pyvenv-3.4
IPYTHONDIR ?= $(shell python -c 'import os; print (os.path.abspath("lib/ipython"))')

IPYTHON = ipython

CURL=curl -L

DIR_FLAG = --ipython-dir=${IPYTHONDIR}

IPYTHON_INSTALL=${IPYTHON} install-nbextension ${DIR_FLAG}

DOWNLOAD_DIR=share/downloads
EXT_DIR=${IPYTHONDIR}/nbextensions

.PHONY: all env use run install

all: env

env: pyvenv.cfg

pyvenv.cfg:
	${PYVENV} --system-site-packages --symlinks .

use:
	@echo "Cannot be done from make. Run this code in terminal:"
	@echo "source bin/activate"

##
# Download Commands
${DOWNLOAD_DIR}: env
	mkdir -p $@

${DOWNLOAD_DIR}/live_reveal-master.zip: ${DOWNLOAD_DIR}
	${CURL} https://github.com/damianavila/live_reveal/archive/master.zip -o share/downloads/live_reveal-master.zip


##
# Install Commands
install: ${EXT_DIR}/livereveal


${EXT_DIR}/livereveal: ${DOWNLOAD_DIR}/live_reveal-master.zip
	unzip $< -dtmp
	# ${IPYTHON} live_reveal-master/Install_RJSE.ipynb ${DIR_FLAG}
	#${IPYTHON_INSTALL} tmp/live_reveal-master/livereveal ${DIR_FLAG}
	cd tmp/live_reveal-master && IPYTHONDIR=${IPYTHONDIR} python setup.py install
	rm -r tmp/live_reveal-master



run:
	${IPYTHON} notebook ${DIR_FLAG} --notebook-dir=notebooks --matplotlib



