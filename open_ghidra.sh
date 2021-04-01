#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

file=$DIR/stuff/Ghidra/ghidra_9.2.2_PUBLIC/ghidraRun

if [[ ! -f $file ]]; then
    echo "Run init.sh first!"
    exit 1
fi

$DIR/stuff/Ghidra/ghidra_9.2.2_PUBLIC/ghidraRun $DIR/project/KnifeEdge_NoseGunner.gpr