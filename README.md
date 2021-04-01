# KE-NG_Reversing
Reversing the N64 game Knife Edge - Nose Gunner

This repo sets up an environment that allows you to:
- run the ROM in an Mupen64Plus Reverser's Edition instance
- open the ROM in Ghidra with the N64 loader plugin
- use the n64tools

The repo also provides:
- a preconfigured Ghidra project for the ROM
- shortcut scripts for most common tasks

#Prerequisites
- Java SDK
- Gradle
- Python3
- pip3
- The following packages:

```
sudo apt-get install build-essential libsdl2-dev libsdl-ttf2.0-0 libsdl-ttf2.0-dev libyaml-0-2 libyaml-dev binutils binutils-dev libpng16-16 libpng-dev freetype2-demos zlib1g zlib1g-dev pyqt5-dev-tools python3-pyqt5 pyqt5-dev-tools qttools5-dev-tools python3-pyqt5.qtopengl
```

*Note: These are the packages that are explicitly listed as dependencies of the projects this is referencing, and others that were missing on my system while testing, results may vary*

#Getting started

Run `source init.sh` to fetch and install dependent components (may take a few minutes).
The script must be sourced since it sets up environment variables to add the local instance of mupen64plus and the n64tools to PATH of the current shell for convenience.

Afterwards, run `./open_ghidra.sh` to run Ghidra and open the project for the ROM and/or run './run_cli.sh' to run the ROM in Mupen64Plus via the console frontend.
*`./run_gui.sh` to start it via the Python+QT frontend is currently a work in progress.*