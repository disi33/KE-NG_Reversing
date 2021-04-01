#!/bin/bash

pop() {
    popd > /dev/null
}

push() {
    pushd $1 > /dev/null
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script must be sourced, since it updates PATH variables for the parent shell"
    echo "Run 'source init.sh' instead!"
    exit 1
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

if [[ -z "$(which python)" ]]; then
    if [[ -z "$(which python3)" ]]; then
        echo "Install Python3 before running init.sh"
        exit 1
    fi
fi

if [[ -z "$(which pip)" ]]; then
    if [[ -z "$(which pip3)" ]]; then
        echo "Install Pip for Python3 before running init.sh"
        exit 1
    fi
fi

PYTHON_BIN=python
PYTHON_MAJOR_VERSION=$($PYTHON_BIN --version 2>&1 | awk '{ print $2 }' | awk -F '.' '{ print $1 }')
if [[ $PYTHON_MAJOR_VERSION -lt 3 ]]; then
    PYTHON_BIN=python3
    if [[ -z "$(which $PYTHON_BIN)" ]]; then
        echo "Error: Python3 not detected properly"
        exit 1
    fi
fi

PIP_BIN=pip
PIP_PYTHON_MAJOR_VERSION=$($PIP_BIN --version | awk '{ print $6 }' | awk -F '.' '{ print $1 }')
if [[ $PIP_PYTHON_MAJOR_VERSION -lt 3 ]]; then
    PIP_BIN=pip3
    if [[ -z "$(which $PIP_BIN)" ]]; then
        echo "Error: Pip for Python3 not detected properly"
        exit 1
    fi
fi

echo "Check prerequisites"
if [[ "$(which javac)" == *not\ found ]]; then 
    echo "Please install Java SDK 11 first"
    echo "You can try running 'sudo apt-get install openjdk-11-jdk' to do so."
    exit 1
fi

javac_version=$(javac --version 2> /dev/null | grep javac | awk -F ' ' '{ print $2 }' | awk -F '.' '{ print $1 }') 2> /dev/null
if [[ $javac_version -lt 11 ]]; then 
    echo "Please install Java SDK 11 first"
    echo "You can try running 'sudo apt-get install openjdk-11-jdk' to do so."
    exit 1
fi

if [[ "$(which gradle)" == *not\ found ]]; then 
    echo "Please install Gradle first"
    echo "You can try running 'sudo apt-get install gradle' to do so."
    exit 1
fi

if [[ "$(which pip)" == *not\ found ]]; then 
    echo "Please install pip first"
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "build-essential")
if [[ -z "$output" ]]; then
    echo "Please install build essentials first"
    echo "You can try running 'sudo apt-get install build-essential' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "libsdl2-dev")
if [[ -z "$output" ]]; then
    echo "Please install build essentials first"
    echo "You can try running 'sudo apt-get install libsdl2-dev' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "libsdl-ttf2.0-dev")
if [[ -z "$output" ]]; then
    echo "Please install libsdl2 TTF libraries + headers first"
    echo "You can try running 'apt-get install libsdl-ttf2.0-0 libsdl-ttf2.0-dev' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "libyaml-dev")
if [[ -z "$output" ]]; then
    echo "Please install libyaml headers first"
    echo "You can try running 'sudo apt-get install libyaml-0-2 libyaml-dev' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "binutils-dev")
if [[ -z "$output" ]]; then
    echo "Please install binutils headers first"
    echo "You can try running 'sudo apt-get install binutils binutils-dev' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "libpng-dev")
if [[ -z "$output" ]]; then
    echo "Please install libpng + headers first"
    echo "You can try running 'sudo apt-get install libpng16-16 libpng-dev' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "freetype2-demos")
if [[ -z "$output" ]]; then
    echo "Please install Freetype 2 first"
    echo "You can try running 'sudo apt-get install freetype2-demos' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "zlib1g-dev")
if [[ -z "$output" ]]; then
    echo "Please install zlib + headers first"
    echo "You can try running 'sudo apt-get install zlib1g zlib1g-dev' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "pyqt5-dev-tools")
if [[ -z "$output" ]]; then
    echo "Please install PyQt5 first"
    echo "You can try running 'sudo apt-get install pyqt5-dev-tools' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "python3-pyqt5")
if [[ -z "$output" ]]; then
    echo "Please install PyQt5 first"
    echo "You can try running 'sudo apt-get install python3-pyqt5' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "pyqt5-dev-tools")
if [[ -z "$output" ]]; then
    echo "Please install PyQt5 Dev Tools first"
    echo "You can try running 'sudo apt-get install pyqt5-dev-tools' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "qttools5-dev-tools")
if [[ -z "$output" ]]; then
    echo "Please install Qt5 Dev Tools first"
    echo "You can try running 'sudo apt-get install qttools5-dev-tools' to do so."
    exit 1
fi

output=$(apt list --installed 2> /dev/null | grep "python3-pyqt5.qtopengl")
if [[ -z "$output" ]]; then
    echo "Please install PyQt5 EopenGL plugin first"
    echo "You can try running 'sudo apt-get install python3-pyqt5.qtopengl' to do so."
    exit 1
fi


if [[ ! -f $DIR/game/Knife\ Edge\ -\ Nose\ Gunner\ \(USA\).zip ]]; then
    echo "You need to provide the game ROM, please see ./game/game.txt"
    exit 1
fi
if [[ ! -f $DIR/game/keng.n64 ]]; then
    echo "Unzip game ROM"
    push $DIR/game
    unzip Knife\ Edge\ -\ Nose\ Gunner\ \(USA\).zip
    # copy the game to keep the original around
    cp Knife\ Edge\ -\ Nose\ Gunner\ \(USA\).n64 keng.n64
    pop
fi

if [[ ! -d $DIR/stuff ]]; then
    mkdir $DIR/stuff
fi

if [[ ! -d $DIR/stuff/Ghidra ]]; then
    echo "get Ghidra"
    mkdir $DIR/stuff/Ghidra
fi
if [[ ! -f $DIR/stuff/Ghidra/ghidra_9.2.2_PUBLIC_20201229.zip ]]; then
    curl https://ghidra-sre.org/ghidra_9.2.2_PUBLIC_20201229.zip -o $DIR/stuff/Ghidra/ghidra_9.2.2_PUBLIC_20201229.zip
fi

if [[ ! -d $DIR/stuff/Ghidra/ghidra_9.2.2_PUBLIC ]]; then
    echo "unpack Ghidra"
    push $DIR/stuff/Ghidra
    unzip ghidra_9.2.2_PUBLIC_20201229.zip > /dev/null
    pop
fi

if [[ ! -d $DIR/stuff/sm64tools ]]; then
    echo "install sm64tools"
    push $DIR/stuff
    git clone --recurse-submodules https://github.com/queueRAM/sm64tools.git > /dev/null 2> /dev/null
    pop
fi
if [[ ! -f $DIR/stuff/sm64tools/n64split ]]; then
    echo "build sm64tools"
    push $DIR/stuff/sm64tools
    make > /dev/null 2> /dev/null
    pop
fi

if [[ ! -d $DIR/stuff/mupen64plus-core ]]; then
    echo "fetch Mupen64Plus Reversers Edition core"
    push $DIR/stuff
    git clone --recurse-submodules https://github.com/disi33/mupen64plus-core.git > /dev/null 2> /dev/null
    pop
fi
if [[ ! -f $DIR/stuff/mupen64plus-core/projects/unix/libmupen64plus.so.2.0.0 ]]; then
    echo "install Mupen64Plus Reversers Edition core"
    push $DIR/stuff/mupen64plus-core/projects/unix > /dev/null
    make all DEBUGGER=1 DEBUG=1 > /dev/null 2> /dev/null
    pop
fi

if [[ -z "$(pip3 list 2> /dev/null | grep PySDL2)" ]]; then
    echo "install PySDL2"
    $PIP_BIN install -U pysdl2 > /dev/null 2> /dev/null
fi

if [[ ! -d $DIR/stuff/mupen64plus-ui-console ]]; then
    echo "fetch Mupen64Plus CLI"
    push $DIR/stuff
    git clone --recurse-submodules https://github.com/mupen64plus/mupen64plus-ui-console.git > /dev/null 2> /dev/null
    push $DIR/stuff/mupen64plus-ui-console
    git checkout tags/2.5.9 > /dev/null 2> /dev/null
    pop
    pop
fi
if [[ ! -d $DIR/stuff/mp64plugins ]]; then
    mkdir $DIR/stuff/mp64plugins > /dev/null
fi
if [[ ! -d $DIR/stuff/mp64plugins/mupen64plus ]]; then
    mkdir $DIR/stuff/mp64plugins/mupen64plus > /dev/null
fi
if [[ ! -d $DIR/stuff/mupen64plus-ui-console/build/bin ]]; then
    echo "install Mupen64Plus GUI"
    push $DIR/stuff/mupen64plus-ui-console/projects/unix
    make all COREDIR=$DIR/stuff/mupen64plus-core/project/unix/ PLUGINDIR=$DIR/stuff/mp64plugins/mupen64plus > /dev/null 2> /dev/null
    make install BINDIR=$DIR/stuff/mupen64plus-ui-console/build/bin MANDIR=$DIR/stuff/mupen64plus-ui-console/build/man > /dev/null 2> /dev/null
    pop
fi

if [[ ! -d $DIR/stuff/mupen64plus-input-sdl ]]; then
    echo "fetch Mupen64Plus SDL input plugin"
    push $DIR/stuff
    git clone --recurse-submodules https://github.com/mupen64plus/mupen64plus-input-sdl.git > /dev/null 2> /dev/null
    push $DIR/stuff/mupen64plus-ui-console
    git checkout tags/2.5.9 > /dev/null 2> /dev/null
    pop
    pop
fi
if [[ ! -f $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-input-sdl.so ]]; then
    echo "install Mupen64Plus SDL input plugin"
    push $DIR/stuff/mupen64plus-input-sdl/projects/unix
    make all > /dev/null 2> /dev/null
    make install LIBDIR=$DIR/stuff/mp64plugins > /dev/null 2> /dev/null
    pop
fi

if [[ ! -d $DIR/stuff/mupen64plus-audio-sdl ]]; then
    echo "fetch Mupen64Plus SDL audio plugin"
    push $DIR/stuff
    git clone --recurse-submodules https://github.com/mupen64plus/mupen64plus-audio-sdl.git > /dev/null 2> /dev/null
    push $DIR/stuff/mupen64plus-ui-console
    git checkout tags/2.5.9 > /dev/null 2> /dev/null
    pop
    pop
fi
if [[ ! -f $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-audio-sdl.so ]]; then
    echo "install Mupen64Plus SDL audio plugin"
    push $DIR/stuff/mupen64plus-audio-sdl/projects/unix
    make all > /dev/null 2> /dev/null
    make install LIBDIR=$DIR/stuff/mp64plugins > /dev/null 2> /dev/null
    pop
fi

if [[ ! -d $DIR/stuff/mupen64plus-video-rice ]]; then
    echo "fetch Mupen64Plus RICE video plugin"
    push $DIR/stuff
    git clone --recurse-submodules https://github.com/mupen64plus/mupen64plus-video-rice.git > /dev/null 2> /dev/null
    push $DIR/stuff/mupen64plus-ui-console
    git checkout tags/2.5.9 > /dev/null 2> /dev/null
    pop
    pop
fi
if [[ ! -f $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-video-rice.so ]]; then
    echo "install Mupen64Plus RICE video plugin"
    push $DIR/stuff/mupen64plus-video-rice/projects/unix
    make all > /dev/null 2> /dev/null
    make install LIBDIR=$DIR/stuff/mp64plugins > /dev/null 2> /dev/null
    pop
fi

if [[ ! -d $DIR/stuff/mupen64plus-rsp-hle ]]; then
    echo "fetch Mupen64Plus HLE RSP processor plugin"
    push $DIR/stuff
    git clone --recurse-submodules https://github.com/mupen64plus/mupen64plus-rsp-hle.git > /dev/null 2> /dev/null
    push $DIR/stuff/mupen64plus-ui-console
    git checkout tags/2.5.9 > /dev/null 2> /dev/null
    pop
    pop
fi
if [[ ! -f $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-rsp-hle.so ]]; then
    echo "install Mupen64Plus HLE RSP processor plugin"
    push $DIR/stuff/mupen64plus-rsp-hle/projects/unix
    make all > /dev/null 2> /dev/null
    make install LIBDIR=$DIR/stuff/mp64plugins > /dev/null 2> /dev/null
    pop
fi

if [[ ! -d $DIR/stuff/N64LoaderWV ]]; then
    echo "fetch Ghidra N64 loader plugin"
    push $DIR/stuff
    git clone --recurse-submodules https://github.com/zeroKilo/N64LoaderWV.git > /dev/null 2> /dev/null
    pop
fi
if [[ ! -d ~/.ghidra/.ghidra_9.2.2_PUBLIC/Extensions/N64LoaderWV/ ]]; then
    if [[ ! -d ~/.ghidra ]]; then
        mkdir ~/.ghidra > /dev/null
    fi
    if [[ ! -d ~/.ghidra/.ghidra_9.2.2_PUBLIC ]]; then
        mkdir ~/.ghidra/.ghidra_9.2.2_PUBLIC > /dev/null
    fi
    if [[ ! -d ~/.ghidra/.ghidra_9.2.2_PUBLIC/Extensions ]]; then
        mkdir ~/.ghidra/.ghidra_9.2.2_PUBLIC/Extensions > /dev/null
    fi
    echo "install Ghidra N64 loader plugin"
    push $DIR/stuff/N64LoaderWV
    GHIDRA_INSTALL_DIR=$DIR/stuff/Ghidra/ghidra_9.2.2_PUBLIC gradle
    cp $DIR/stuff/N64LoaderWV/dist/ghidra_9.2.2_PUBLIC_20210401_N64LoaderWV.zip ~/.ghidra/.ghidra_9.2.2_PUBLIC/Extensions > /dev/null
    pop
    push ~/.ghidra/.ghidra_9.2.2_PUBLIC/Extensions
        unzip ghidra_9.2.2_PUBLIC_20210401_N64LoaderWV.zip
        rm ghidra_9.2.2_PUBLIC_20210401_N64LoaderWV.zip > /dev/null
    pop
fi

###################################################################################################
# not installing python GUI for now until I can figure out how to make it load custom core reliably
###################################################################################################

# if [[ ! -d $DIR/stuff/mupen64plus-ui-python ]]; then
#     echo "fetch Mupen64Plus GUI"
#     push $DIR/stuff
#     git clone --recurse-submodules https://github.com/mupen64plus/mupen64plus-ui-python.git > /dev/null 2> /dev/null
#     pop
# fi
# if [[ ! -f $DIR/stuff/mupen64plus-ui-python/build/lib/m64py.py ]]; then
#     echo "install Mupen64Plus GUI"
#     push $DIR/stuff/mupen64plus-ui-python
#     $PYTHON_BIN setup.py build
#     $PYTHON_BIN setup.py install --install-dir $DIR/stuff/mupen64plus-ui-python/bin
#     cp $DIR/stuff/mupen64plus-ui-python/bin/m64py $DIR/stuff/mupen64plus-ui-python/build/lib/m64py.py
#     pop
# fi
# if [[ ! -L $DIR/stuff/mupen64plus-ui-python/build/lib/libmupen64plus.so.2 ]]; then
#     echo "configure Mupen64Plus GUI to use custom core module"
#     ln -sf $DIR/stuff/mupen64plus-core/project/unix/libmupen64plus.so.2.0.0 $DIR/stuff/mupen64plus-ui-python/build/lib/libmupen64plus.so.2
# fi

if [[ ! "$PATH" =~ .*\/stuff\/sm64tools.* ]]; then
    export PATH="$PATH:$DIR/stuff/sm64tools"
fi
if [[ ! "$PATH" =~ .*\/stuff\/mupen64plus-ui-console\/build\/bin.* ]]; then
    export PATH="$PATH:$DIR/stuff/mupen64plus-ui-console/build/bin"
fi