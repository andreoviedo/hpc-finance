CC = icc

#CFLAGS = -std=c++11 -O2 -qopt-report=1
CFLAGS = -std=c++11 -g -Wall -qopt-report=1

BS1 = bs1.cpp

all: bs1 

bs1 : $(BS1)
	$(CC) $(CFLAGS)  $< -o $@

clean:
	rm -rf bs1 *.optrpt

