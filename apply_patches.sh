# Apply each of the Qt patches.  Thsi should be run in the top-level directory
# of the Qt sources.


# Check the current directory.
if [ ! -f "qt.pro" ]
then
    echo "Run from the top-level directory of the Qt sources"
    exit 1
fi


# The directory containing the patches directories.
ROOT_DIR=`dirname $0`


# Apply an official patch.  Note that the latest version of Qt has no official
# patches.
official()
{
    diff_name=`realpath $ROOT_DIR/OfficialPatches/$1`

    if [ -z "$2" ]
    then
        base_dir=qtbase
    else
        base_dir=$2
    fi

    cd $base_dir
    patch -p1 <$diff_name
    cd -
}


# Apply an unofficial patch.
unofficial()
{
    diff_name=$ROOT_DIR/UnofficialPatches/$1

    patch -p1 <$diff_name
}


# The unofficial patches.
unofficial 01-xcode-14.1.diff
unofficial 03-xcode-15-stdlib.diff
unofficial 04-wayland.diff
unofficial 05-xcode-15-stdlib.diff
unofficial 06-boost_build-with-newer-clang.diff
unofficial 07-webengine-with-newer-ninja.diff
unofficial 08-webengine-with-newer-clang.diff
