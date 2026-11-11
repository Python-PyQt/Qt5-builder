# Building Qt v5 for macOS

Xcode v15.4 is known to work and there is no reason to suppose later versions
wouldn't.

> [!NOTE]
> Each architecture is built separately.  This is because (possibly
> historically) a universal build of the Designer library was not created.
> Resolving thsi would make the following process much simpler.


## Patching the Sources

From the top-level directory of the Qt sources run:

    sh /path/to/Qt5-builder/apply_patches.sh


## Configuration and Prerequisites

To install `Node.js`, run:

    open /path/to/node-vX.Y.Z.pkg

v18.20.3 is known to work and there is no reason to suppose later versions
wouldn't.

All remaining commands to build Qt v5 for x86_64 must be done from a shell
running in a Rosetta terminal.  To create an appropriate desktop shortcut right
click on `Terminal` (or `iTerm`) in `Applications` and select `Duplicate`.
Rename the duplicate to `Terminal x86_64` and right click on it.  Check `Open
using Rosetta`.

Install Homebrew in both a Rosetta terminal and an ordinary terminal.  Edit
`~/.bash_profile` and add:

    if [ $(arch) = "i386" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
        export PS1='\h-x86_64:\W \u\$ '
    else
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

Start a new terminal so that `brew` is on `PATH`.

It's easier to install Python v2.7 than to patch the Qt sources to support
Python v3.  `pyenv` is used to build Python v2.7 which itself is built using
Homebrew.

To install `pyenv`, run:

    brew install pyenv

Edit `~/.bash_profile` and add:

    export PATH=$HOME/.pyenv/bin:$PATH
    eval "$(pyenv init -)"

Start a new terminal so that `pyenv` is on `PATH`.

To install Python v2, run:

    pyenv install 2.7.18

To install the remaining prerequisites, run:

    brew install pkg-config
    brew install postgresql@15
    brew install unixodbc


## Building

To configure the build environment (in an appropriate terminal), run:

    pyenv global 2.7.18

If a different version of Xcode is used for general development, run:

    sudo xcode-select -s /Applications/Xcode-15.4.app
    sudo xcrun xcodebuild -license accept

To configure the Qt sources for x86_64, run:

    ./configure \
        QMAKE_CXXFLAGS+=-Wno-enum-constexpr-conversion \
        -prefix /path/to/target/installation/x86_64 \
        -opensource \
        -confirm-license \
        -release \
        -skip virtualkeyboard \
        -nomake examples \
        -nomake tests \
        -I /usr/local/Cellar/unixodbc/2.3.12/include \
        -L /usr/local/Cellar/unixodbc/2.3.12/lib \
        -I /usr/local/opt/postgresql@15/include \
        -L /usr/local/opt/postgresql@15/lib

To configure the Qt sources for arm64, run:

    ./configure \
        QMAKE_CXXFLAGS+=-Wno-enum-constexpr-conversion \
        -prefix /path/to/target/installation/arm64 \
        -opensource \
        -confirm-license \
        -release \
        -skip virtualkeyboard \
        -nomake examples \
        -nomake tests \
        -I /opt/homebrew/Cellar/unixodbc/2.3.12/include \
        -L /opt/homebrew/Cellar/unixodbc/2.3.12/lib \
        -I /opt/homebrew/opt/postgresql@15/include \
        -L /opt/homebrew/opt/postgresql@15/lib

To build and install Qt, run:

    make -j8
    make install

To reset the build environment, run:

    pyenv global system

If a different version of Xcode is used for general development, run:

    sudo xcode-select -s /Applications/Xcode-X.Y.Z.app
    sudo xcrun xcodebuild -license accept
