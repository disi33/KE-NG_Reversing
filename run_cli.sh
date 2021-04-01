#!/bin/bash

usage() {
    echo "usage: ./run_gui.sh [--help] [--original]"
    echo "    -h | --help:     display usage"
    echo "    -o | --original: run the original ROM rather than the modified one"
    echo "    -d | --debug:    start Mupen64Plus in debug mode"
}

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

ROM_FILE=keng.n64
DEBUG_PARAM=""

while [ ! -z "$1" ];do
    case "$1" in
        -h|--help)
            echo "Runs the ROM in Mupen64Plus Python GUI"
            echo ""
            usage
            exit 0
            ;;
        -d|--debug)
            shift
            DEBUG_PARAM="--debug"
            ;;
        -o|--original)
            shift
            ROM_FILE=Knife\ Edge\ -\ Nose\ Gunner\ \(USA\).n64
            ;;
        *)
            echo "Error: unknown parameter '$1'!"
            echo ""
            usage
            exit 1
    esac
shift
done

$DIR/stuff/mupen64plus-ui-console/build/bin/mupen64plus $DEBUG_PARAM \
    --gfx $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-video-rice.so \
    --audio $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-audio-sdl.so \
    --input $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-input-sdl.so \
    --rsp $DIR/stuff/mp64plugins/mupen64plus/mupen64plus-rsp-hle.so \
    "$DIR/game/$ROM_FILE"