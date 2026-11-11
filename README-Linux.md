# Building Qt v5 for Linux

In order to maintain maximum compatibility with the binaries contained in the
Qt on-line installers (particularly the libc and libstdc++ ABI versions) the
build should be done on CentOS 7 with devtoolset-4 (gcc v5.3.1, libc ABI v2.17,
libstdc++ ABI v6.0.19).


## Patching the Sources

From the top-level directory of the Qt sources run:

    sh /path/to/Qt5-builder/apply_patches.sh


## Configuration and Prerequisites

To install additional prerequisites, run:

    sudo yum -y install patch
    sudo yum -y install which
    sudo yum -y install p7zip
    sudo yum -y install bison
    sudo yum -y install flex
    sudo yum -y install gperf
    sudo yum -y install nodejs
    sudo yum -y install alsa-lib-devel
    sudo yum -y install bluez-libs-devel
    sudo yum -y install cups-devel
    sudo yum -y install dbus-devel
    sudo yum -y install fontconfig-devel
    sudo yum -y install gstreamer1-devel
    sudo yum -y install gstreamer1-plugins-base-devel
    sudo yum -y install libwayland-client-devel
    sudo yum -y install libXcomposite-devel
    sudo yum -y install libXcursor-devel
    sudo yum -y install libXi-devel
    sudo yum -y install libxkbcommon-x11-devel
    sudo yum -y install libxkbfile-devel
    sudo yum -y install libXrandr-devel
    sudo yum -y install libXtst-devel
    sudo yum -y install mesa-libEGL-devel
    sudo yum -y install nss-devel
    sudo yum -y install postgresql-devel
    sudo yum -y install pulseaudio-libs-devel
    sudo yum -y install speech-dispatcher-devel
    sudo yum -y install unixODBC-devel
    sudo yum -y install xcb-util-devel
    sudo yum -y install xcb-util-image-devel
    sudo yum -y install xcb-util-keysyms-devel
    sudo yum -y install xcb-util-renderutil-devel
    sudo yum -y install xcb-util-wm-devel

To install ICU, run:

    mkdir $HOME/icu
    cd $HOME/icu
    7za x /path/to/Qt5-builder/icu/icu-linux-g++-Rhel7.2-x64-devel.7z


## Building

To configure the Qt sources, run:

    ./configure \
        -prefix /path/to/target/installation/gcc_64 \
        -opensource \
        -confirm-license \
        -release \
        -no-strip \
        -skip virtualkeyboard \
        -no-sql-mysql \
        -nomake examples \
        -nomake tests \
        -xcb \
        -xcb-xlib \
        -bundled-xcb-xinput \
        -qt-harfbuzz \
        -qt-libjpeg \
        -qt-libpng \
        -no-mng \
        -I /usr/include/openssl11 \
        -L /usr/lib64/openssl11 \
        -I $HOME/icu/include \
        -L $HOME/icu/lib

To build and install Qt, run:

    LD_LIBRARY_PATH=$HOME/icu/lib make
    make install

To install the ICU libraries, run:

    cd /path/to/target/installation/gcc_64/lib
    7za x /path/to/Qt-builder/icu/icu-linux-g++-Rhel7.2-x64.7z

To fix the rpaths, run:

    cd /path/to/target/installation/gcc_64/lib
    patchelf --set-rpath '$ORIGIN' libicui18n.so
    patchelf --set-rpath '$ORIGIN' libicuuc.so
    patchelf --set-rpath '$ORIGIN' libQt5Core.so
