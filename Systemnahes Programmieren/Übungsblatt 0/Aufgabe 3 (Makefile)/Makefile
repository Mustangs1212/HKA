CC = gcc
CFLAGS = -Wall -Wextra -std=c11 -I.

DEPS = functions.h
OBJ = main.o functions.o

all: final

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

final: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	rm -f *.o final
