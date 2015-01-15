CC=arm-frc-linux-gnueabi-g++
CFLAGS=-std=c++11 -O0 -g3 -Wall -c -fmessage-length=0
LDFLAGS=-Wl,-rpath,/opt/GenICam_v2_3/bin/Linux_armv7-a
SOURCES=$(shell find -name "*.cpp")
OBJECTS=$(SOURCES:.cpp=.o)
WPILIB=/var/frc/wpilib/
EXEC=bin/FRCUserProgram
CLEANSER=rm -r


all : $(OBJECTS)
	$(CC) -L$(WPILIB)/lib $(LDFLAGS) -o $(EXEC) $(OBJECTS) -lwpi

%.o : %.cpp
	$(CC) $(CFLAGS) -I$(WPILIB)/include $^ -o $@

clean:
	$(CLEANSER) $(OBJECTS)
