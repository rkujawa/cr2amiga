# This is actually a C program, however... Digilent include files require C++ compiler, doh!
CXX=g++

CXXFLAGS=-I/usr/local/include/digilent/adept
LDFLAGS=-L/usr/local/lib64/digilent/adept -ldmgr -ldepp 
DEPP_POKE_OBJS=depp-poke.o

all : depp-poke

depp-poke : $(DEPP_POKE_OBJS)
	$(CXX) -o depp-poke $(LDFLAGS) $(DEPP_POKE_OBJS)

%.o : %.cpp
	$(CXX) $(CXXFLAGS) -c $<

clean :
	rm -f depp-poke
	rm -f *.o
