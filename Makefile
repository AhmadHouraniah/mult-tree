CXX = g++
OBJ = generate_PPM
SRC = generate_PPM.cpp
CFLAGS = -O3

all:
	$(CXX) $(CFLAGS) -o ../FB42DSP/$(OBJ) $(SRC)

debug:
	$(CXX) -g -DDEBUG $(CFLAGS) -o $(OBJ) $(SRC)

clean:
	rm -rf $(OBJ) *.vhd
