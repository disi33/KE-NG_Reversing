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

$DIR/stuff/mupen64plus-ui-console/build/bin/mupen64plus \
    --gfx $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-video-rice.so \
    --audio $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-audio-sdl.so \
    --input $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-input-sdl.so \
    --rsp $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-rsp-hle.so \
    "$DIR/game/$ROM_FILE"