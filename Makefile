FILENAME = `date +blog.runningstream.net_%Y_%m_%d`

.PHONY: all check_URLs check_spelling

all: check_URLs check_spelling
	rm -rf public
	hugo
	mv public ${FILENAME}
	tar cfj ${FILENAME}.tar.bz2 ${FILENAME}
	rm -rf ${FILENAME}

check_URLs:
	./check_URLs.sh

check_spelling:
	./check_spelling.sh
