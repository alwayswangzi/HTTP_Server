CC = g++
SRC = src
INCLUDE = include
BIN = bin
OBJ = obj
LFLAGS = -std=c++11 -pthread -lboost_system
OBJECTS_ = main.o connection.o \
		connection_manager.o mime_types.o \
		reply.o request_handler.o \
		request_parser.o server.o		  
OBJECTS = $(patsubst %,$(OBJ)/%,$(OBJECTS_))		  

http_server:$(OBJECTS)
	$(CC) $(LFLAGS) -o $(BIN)/http_server $(OBJECTS)
	@echo "[build success!]"

#$(OBJ)/%.o:$(SRC)/%.cpp
#	$(CC) -I$(INCLUDE) $(LFLAGS) -c -o $@ $<  

$(OBJ)/main.o:$(SRC)/main.cpp $(INCLUDE)/server.hpp
	$(CC) -I$(INCLUDE) $(LFLAGS) -c -o $@ $< 

$(OBJ)/connection.o:$(SRC)/connection.cpp $(INCLUDE)/connection.hpp $(INCLUDE)/connection_manager.hpp $(INCLUDE)/request_handler.hpp
	$(CC) -I$(INCLUDE) $(LFLAGS) -c -o $@ $<

$(OBJ)/connection_manager.o:$(SRC)/connection_manager.cpp $(INCLUDE)/connection_manager.hpp
	$(CC) -I$(INCLUDE) $(LFLAGS) -c -o $@ $<
	
$(OBJ)/mime_types.o:$(SRC)/mime_types.cpp $(INCLUDE)/mime_types.hpp
	$(CC) -I$(INCLUDE) $(LFLAGS) -c -o $@ $<	
	
$(OBJ)/reply.o:$(SRC)/reply.cpp $(INCLUDE)/reply.hpp
	$(CC) -I$(INCLUDE) $(LFLAGS) -c -o $@ $<

$(OBJ)/request_handler.o:$(SRC)/request_handler.cpp $(INCLUDE)/request_handler.hpp $(INCLUDE)/mime_types.hpp $(INCLUDE)/reply.hpp $(INCLUDE)/request.hpp
	$(CC) -I$(INCLUDE) $(LFLAGS) -c -o $@ $<
	
$(OBJ)/request_parser.o:$(SRC)/request_parser.cpp $(INCLUDE)/request_parser.hpp $(INCLUDE)/request.hpp
	$(CC) -I$(INCLUDE) $(LFLAGS) -c -o $@ $<
	
$(OBJ)/server.o:$(SRC)/server.cpp $(INCLUDE)/server.hpp
	$(CC) -I$(INCLUDE) $(LFLAGS) -c -o $@ $<
	
.PHONY:clean
clean:
	rm $(OBJ)/*.o $(BIN)/http_server	
	
