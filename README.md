# Qt5-builder

This repository contains instructions and patches for building Qt v5 from
source.  The motivation is to provide a Qt installation from which the
[PyQt5-Qt5](https://pypi.org/project/PyQt5-Qt5/) Python wheels can be
generated.  Historically a Qt installation was obtained by using the online
installer, however the later versions of Qt v5 were only available as source
packages.  In particular binaries for running Qt v5 on Apple silicon were never
provided.

> [!NOTE]
> At the moment building for Windows is not supported.

To build Qt v5 simply clone this repository, obtain a copy of the Qt v5 source
tarball, unpack it and follow the instructions in the platform-specific
`README` file.

The Qt v5 source tarball can be obtained from the
[Qt Source Archives](https://download.qt.io/archive/qt/5.15/).
