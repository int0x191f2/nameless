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
    echo ">> WPILib not found in /var/frc/. Creating a clone"
    echo ">> **root is required for writing to /var/frc initally (will be chmodded)"
    sudo mkdir -p /var/frc && sudo chmod -R 707 /var/frc
    git clone https://github.com/stonewareslord/wpilib.git /var/frc/wpilib
fi
