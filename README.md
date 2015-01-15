# Nameless
This project aims to eliminate the need for Eclipse to compile code for FRC (First Robotics Competition) via the use of a custom makefile.

# Install
Installation only requires git and make being installed on a POSIX/GNU machine.

Simply clone the latest copy of master into the src/ directory of your existing eclipse project, copy everything up a directory, and run configure.sh.
```sh
cd ~/workspace/tmp/src
git clone https://github.com/int0x191f2/nameless.git a && mv a/{configure.sh,Makefile} . && rm -rf a
git
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
