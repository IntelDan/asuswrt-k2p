# asuswrt-k2p
Port asuswrt-rt-ac1200g+ to phicomm k2p and added some merlin features

### Install Dependencies

``` bash
sudo apt-get install --no-install-recommends autoconf automake bash bison bzip2 diffutils file flex g++ gawk gcc-multilib gettext gperf groff-base libncurses-dev libexpat1-dev libslang2 libssl-dev libtool libxml-parser-perl make patch perl pkg-config python sed shtool tar texinfo unzip zlib1g zlib1g-dev

sudo apt-get install lib32stdc++6 lib32z1-dev

sudo apt-get --no-install-recommends install automake1.11

sudo apt-get install libelf-dev:i386 libelf1:i386

sudo apt-get --no-install-recommends install lib32z1-dev lib32stdc++6
```

### Start Build

``` bash
source ./set-env.sh
cd $SRC
make RT-AC1200G+
```

### FAQ

- /usr/lib/libxxx.so not recognized.
	- some configure script give 64bit libdir as link libdir, but toolchains are in 32 bit, you can simply modify the Makefile where to find library and continue build