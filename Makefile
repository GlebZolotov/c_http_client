CFLAGS = -I.. -g -Wall -pedantic -fPIC -shared
#CFLAGS = -O2

ifeq ($(OS),Windows_NT)
	LDFLAGS = -lwinhttp
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		LDFLAGS = -framework Foundation
		CFLAGS += -Wno-gnu-zero-variadic-macro-arguments
	else ifeq ($(UNAME_S),Linux)
		LDFLAGS = -lcurl -lpthread
	endif
endif

all: http_client.so

http_client.o: naett.c 
	gcc -c $(CFLAGS) $(LDFLAGS) $< -o $@

http_client.so: http_client.o 
	gcc $^ -o $@ $(CFLAGS) $(LDFLAGS)

ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif

install: http_client.so
	install -d $(DESTDIR)$(PREFIX)/lib/
	install -m 644 http_client.so $(DESTDIR)$(PREFIX)/lib/
