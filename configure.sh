#!/bin/bash
if [ -a Makefile ] ;then
    cp Makefile Makefile.old
    rm Makefile
fi
echo ">>Fetching the Makefile"
curl -s https://raw.githubusercontent.com/int0x191f2/nameless/master/Makefile -o Makefile
if [ ! -d bin/ ] ;then
    echo ">> Lack of bins. Making a bin for you"
    mkdir bin/
fi

if [ ! -d /var/frc/wpilib/ ] ;then
    echo ">> WPILib headers not found"
    echo ">> **root is required for writing to /var/frc initally (will be chmodded)"
    sudo mkdir -p /var/frc && sudo chmod -R 707 /var/frc
    git clone https://github.com/stonewareslord/wpilib.git /var/frc/wpilib
fi

if [ ! -a /usr/local/include/WPILib.h ] ;then
    echo ">>Complete WPILib library not found. Building..."
    git clone https://usfirst.collab.net/gerrit/allwpilib /tmp/allwpilib
    cd /tmp/allwpilib && mkdir build && cd build
    cmake .. -DCMAKE_TOOLCHAIN_FILE=../arm-toolchain.cmake
    make
    echo "*****************************************"
    echo ">>Root is required to install the library"
    echo "*****************************************"
    cd /tmp/allwpilib/build && sudo make install
fi
