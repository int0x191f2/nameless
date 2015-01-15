# Nameless
This project aims to eliminate the need for Eclipse to compile code for FRC (First Robotics Competition) via the use of a custom makefile.

# Install
Installation only requires git and make being installed on a POSIX/GNU machine.

Simply curl the configure script into the src/ directory of your existing eclipse project and run it
```sh
cd ~/workspace/tmp/src
curl https://raw.githubusercontent.com/int0x191f2/nameless/master/configure.sh | sh
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
