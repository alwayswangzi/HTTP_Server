CC = g++
LDFLAGS = -std=c++11 -pthread -lboost_system
OBJECTS = connection.o connection_manager.o \
		  mime_types.o reply.o request_handler.o \
		  request_parser.o server.o \
		  main.o

all:$(OBJECTS)
	$(CC) -o http_server $(OBJECTS) $(LDFLAGS)

main.o:server.hpp
connection.o:connection.hpp connection_manager.hpp request_handler.hpp
connection_manager.o:connection_manager.hpp
mime_types.o:mime_types.hpp
reply.o:reply.hpp
request_handler.o:request_handler.hpp mime_types.hpp reply.hpp request.hpp
request_parser.o:request_parser.hpp request.hpp
server.o:server.hpp

.PHONY:clean
clean:
	rm http_server $(OBJECTS)
