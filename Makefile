CFLAGS = -I.. -g -Wall -pedantic -fPIC -shared
#CFLAGS = -O2

NAME_END = ".so"
ifeq ($(OS),Windows_NT)
	LDFLAGS = -lwinhttp
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		LDFLAGS = -lcurl -lpthread
		NAME_END = ".dylib"
	else ifeq ($(UNAME_S),Linux)
		LDFLAGS = -lcurl -lpthread
	endif
endif

all: http_client$(NAME_END)

http_client.o: naett.c 
	gcc -c $(CFLAGS) $(LDFLAGS) $< -o $@

http_client$(NAME_END): http_client.o 
	gcc $^ -o $@ $(CFLAGS) $(LDFLAGS)

ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif

install: http_client$(NAME_END)
	install -d $(DESTDIR)$(PREFIX)/lib/
	install -m 644 http_client$(NAME_END) $(DESTDIR)$(PREFIX)/lib/
