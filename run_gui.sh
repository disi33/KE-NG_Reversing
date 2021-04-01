#!/bin/bash

usage() {
    echo "usage: ./run_gui.sh [--help] [--original]"
    echo "    --help:     display usage"
    echo "    --original: run the original ROM rather than the modified one"
}

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

PYTHON_BIN=python
PYTHON_MAJOR_VERSION=$($PYTHON_BIN --version 2>&1 | awk '{ print $2 }' | awk -F '.' '{ print $1 }')
if [[ $PYTHON_MAJOR_VERSION -lt 3 ]]; then
    PYTHON_BIN=python3
    if [[ -z "$(which $PYTHON_BIN)" ]]; then
        echo "Error: Python3 not detected properly"
        exit 1
    fi
fi

ROM_FILE=keng.n64
if [[ ! -z "$1" ]]; then
    if [[ "$1" == "--help" ]]; then
        echo "Runs the ROM in Mupen64Plus Python GUI"
        echo ""
        usage
        exit 0
    elif [[ "$1" == "--original" ]]; then
        ROM_FILE=Knife\ Edge\ -\ Nose\ Gunner\ \(USA\).n64
    else
        echo "Error: unknown parameter '$1'!"
        echo ""
        usage
        exit 1
    fi
fi

echo "This is disabled for now until I can figure out how to make the GUI load the custom core properly!"
echo "Use ./run_cli.sh instead!"
exit 1

LD_LIBRARY_PATH=$DIR/stuff/mupen64plus-core/project/unix/ $PYTHON_BIN $DIR/stuff/mupen64plus-ui-python/build/lib/m64py.py "$DIR/game/$ROM_FILE"