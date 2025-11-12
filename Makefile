BIN := OpenCB
SRC := src/OpenCB.c

CFLAGS += -Wall -Wextra $(shell pkg-config --cflags sdl)
LDLIBS += $(shell pkg-config --libs sdl)

$(BIN): $(SRC)
	$(CC) $(CFLAGS) $^ -o $@ $(LDLIBS)

.PHONY: run clean
run: $(BIN)
	./$(BIN)

clean:
	rm -f $(BIN) *.o
