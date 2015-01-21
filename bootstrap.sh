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
if [ ! -a /usr/bin/arm-frc-linux-gnueabi-g++ ] ;then
    if [ $(which hg) ] && [ $(which cmake) ] && [ $(which wget) ];then
        echo ">>cmake and hg found"
        echo ">>installing frcmake-hg"
        mkdir ~/frctoolchain && cd ~/frctoolchain
        hg clone https://bitbucket.org/byteit101/toolchain-builder
        cd toolchain-builder/tools && sudo make -f frcmake-nix-makefile install
        cd ~/frctoolchain/ && wget ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.9.1/gcc-4.9.1.tar.bz2
        tar -xvjf gcc-4.9.1.tar.bz2
        cd gcc-4.9.1
        curl https://raw.githubusercontent.com/int0x191f2/nameless/master/minorSOname.patch -o a.patch
        patch -p1 < a.patch
        mkdir gcc-build  && cd gcc-build
        ../configure \
            --prefix=/usr \
            --program-prefix=arm-frc-linux-gnueabi- \
            --target=arm-frc-linux-gnueabi \
            --host=$CHOST \
            --build=$CHOST \
            --enable-shared \
            --disable-nls \
            --enable-threads=posix \
            --enable-languages=c,c++ \
            --disable-multilib \
            --disable-multiarch \
            --with-sysroot=/usr/arm-frc-linux-gnueabi \
            --with-build-sysroot=/usr/arm-frc-linux-gnueabi \
            --with-as=/usr/bin/arm-frc-linux-gnueabi-as \
            --with-ld=/usr/bin/arm-frc-linux-gnueabi-ld \
            --with-arch=armv7-a \
            --with-cpu=cortex-a9 \
            --with-float=softfp \
            --with-fpu=vfp \
            --with-specs='%{save-temps: -fverbose-asm} %{funwind-tables|fno-unwind-tables|mabi=*|ffreestanding|nostdlib:;:-funwind-tables}' \
            --enable-lto \
            --with-pkgversion='GCC for FRC' \
            --with-cloog \
            --disable-multiarch \
            --enable-poison-system-directories \
           --enable-plugin \
            --with-system-zlib \
            --disable-libmudflap
        clear && sleep 1 
        echo ">>Initalizing build of gcc"
        sleep 1 && clear
        make
        sudo make install
        clear && sleep 1
        echo ">>Installing arm-frc-linux-gnuabi-binutils"
        sleep 1 && clear
        cd ~/frctoolchain && wget ftp://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.bz2 && tar -xvjf binutils-2.24.tar.bz2 && cd binutils-2.24
        find -name config.cache -exec rm {} \;
        ./configure \
            --prefix=/usr \
            --target=arm-frc-linux-gnueabi \
            --with-pkgversion='GNU Binutils for FRC' \
            --with-sysroot=/usr/arm-frc-linux-gnueabi \
            --disable-multilib \
            --disable-nls \
            --enable-lto \
            --disable-libiberty-install \
            --disable-werror
        make configure-host | tee /tmp/frcinstall.log
        make | tee /tmp/frcinstall.log
        sudo make install | tee /tmp/frcinstall.log
    else
        echo ">>Please install cmake and hg"
    fi
fi
if [ ! -a /usr/local/include/WPILib.h ] ;then
    if [ $(which cmake) ] ;then
        echo ">>Complete WPILib library not found. Building..."
        git clone https://usfirst.collab.net/gerrit/allwpilib /tmp/allwpilib
        cd /tmp/allwpilib && mkdir build && cd build
        cmake .. -DCMAKE_TOOLCHAIN_FILE=../arm-toolchain.cmake | tee /tmp/frcinstall.log
        make | tee /tmp/frcinstall.log
        echo "*****************************************"
        echo ">>Root is required to install the library"
        echo "*****************************************"
        cd /tmp/allwpilib/build && sudo make install
        sudo rm -r /tmp/allwpilib/
    fi
fi

