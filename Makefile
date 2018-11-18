FILENAME = `date +blog.runningstream.net_%Y_%m_%d`

all:
	rm -rf public
	hugo
	mv public ${FILENAME}
	tar cfj ${FILENAME}.tar.bz2 ${FILENAME}
	rm -rf ${FILENAME}
