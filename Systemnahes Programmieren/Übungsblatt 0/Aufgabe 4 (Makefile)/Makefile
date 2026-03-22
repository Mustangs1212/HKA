CC = gcc
CFLAGS = -Wall -Wextra -std=c11 -I.

OBJ = main.o

all: main

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	rm -f *.o main
