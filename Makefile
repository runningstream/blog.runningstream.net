all:
	rm -rf public
	hugo
	tar cfj site.tar.bz2 public
	rm -rf public
