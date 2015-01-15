# Nameless
This project aims to eliminate the need for Eclipse to compile code for FRC (First Robotics Competition) via the use of a custom makefile.

# Install
Installation only requires git and make being installed on a POSIX/GNU machine.
Simply clone this repository into the src folder of your existing eclipse project and run configure.sh.
```sh
cd ~/workspace/tmp/src
git clone https://github.com/int0x191f2/nameless.git .
./configure.sh
```
# Usage
Run make in <project>/src to create the FRCUserProgram in bin/
```sh
make
```
# Todo
-> Auto deploying via ssh/sftp
-> More robust configuration file
-> Auto downloading/building of the frc toolchain
