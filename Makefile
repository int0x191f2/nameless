CC=arm-frc-linux-gnueabi-g++
CFLAGS=-std=c++11 -O0 -g3 -Wall -c -fmessage-length=0
LDFLAGS=-Wl,-rpath,/opt/GenICam_v2_3/bin/Linux_armv7-a
SOURCES=$(shell find -type f -name "*.cpp")
OBJECTS=$(SOURCES:.cpp=.o)
WPILIB=/var/frc/wpilib/
EXEC=bin/FRCUserProgram
CLEANSER=rm -r
REMOTEIP=10.0.1.31

all : $(OBJECTS)
	$(CC) -L$(WPILIB)/lib $(LDFLAGS) -o $(EXEC) $(OBJECTS) -lwpi

%.o : %.cpp
	$(CC) $(CFLAGS) -I$(WPILIB)/include $^ -o $@

clean:
	$(CLEANSER) $(OBJECTS)

deploy:
	@ssh admin@$(REMOTEIP) "rm /home/lvuser/FRCUserProgram"
	@scp bin/FRCUserProgram admin@$(REMOTEIP)
	@ssh admin@$(REMOTEIP) "/etc/profile.d/natinst-path.sh; chmod a+x /home/lvuser/FRCUserProgram; /usr/local/frc/bin/frcKillRobot.sh -t -r"
