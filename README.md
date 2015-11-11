# Nameless
This project aims to eliminate the need for Eclipse to compile code for FRC (First Robotics Competition) via the use of a custom makefile.

# Install
Installation only requires git and make being installed on a POSIX/GNU machine.

Simply curl the configure script into the src/ directory of your existing eclipse project and run it
```sh
cd ~/workspace/tmp/src
curl https://raw.githubusercontent.com/int0x191f2/nameless/master/Makefile -O
```
# Usage
Run make in <project>/src to create the FRCUserProgram in bin/
```sh
make
```

Run make clean to clean all left over objects
```sh
make clean
```

Run make deploy to put the FRCUserProgram onto the robot
```sh
make deploy
```
