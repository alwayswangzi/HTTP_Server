CC = g++
SRC = src/
INCLUDE = include/
BIN = bin/
LFLAGS = -std=c++11 -pthread -lboost_system
OBJECTS = main.o connection.o connection_manager.o \
		  mime_types.o reply.o request_handler.o \
		  request_parser.o server.o \

all:$(OBJECTS)
	$(CC) -o ../bin/http_server $(OBJECTS) $(LFLAGS)

%.o: %.c
	$(CC) -c -o $@ $< $(LFLAGS)
	
.PHONY:clean
clean:
	
	
