#!/bin/bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
AIKON_SETUP="$ROOT_DIR/aikon/scripts/setup.sh"
DISCOVER_SETUP="$ROOT_DIR/discover-api/setup.sh"

colorEcho() {
    Color_Off="\033[0m"
    Red="\033[1;91m"        # Red
    Green="\033[1;92m"      # Green
    Blue="\033[1;94m"       # Blue
    Purple="\033[1;95m"     # Purple

    case "$1" in
        "green") echo -e "$Green$2$Color_Off";;
        "red") echo -e "$Red$2$Color_Off";;
        "blue") echo -e "$Blue$2$Color_Off";;
        "purple") echo -e "$Purple$2$Color_Off";;
        *) echo "$2";;
    esac
}

echoTitle(){
    sep_line="========================================"
    len_title=${#1}

    if [ "$len_title" -gt 40 ]; then
        sep_line=$(printf "%0.s=" $(seq 1 $len_title))
        title="$1"
    else
        diff=$((38 - len_title))
        half_diff=$((diff / 2))
        sep=$(printf "%0.s=" $(seq 1 $half_diff))

        if [ $((diff % 2)) -ne 0 ]; then
            title="$sep $1 $sep="
        else
            title="$sep $1 $sep"
        fi
    fi

    colorEcho purple "\n\n$sep_line\n$title\n$sep_line"
}

echoTitle "AIKON BUNDLE INSTALL"

# Check that both scripts exist
if [ ! -f "$AIKON_SETUP" ]; then
    colorEcho red "AIKON setup script not found"
    exit 1
fi

if [ ! -f "$DISCOVER_SETUP" ]; then
    colorEcho red "Discover setup script not found"
    exit 1
fi

colorEcho green "AIKON installation..."
(cd "$ROOT_DIR/aikon" && bash "$AIKON_SETUP")

if [ $? -ne 0 ]; then
    colorEcho red "AIKON setup encountered an error"
    exit 1
fi

colorEcho green "Discover installation..."
(cd "$ROOT_DIR/discover-api" && bash "$DISCOVER_SETUP")

if [ $? -ne 0 ]; then
    colorEcho red "Discover setup encountered an error"
    exit 1
fi

echoTitle "🎉 AIKON AND DISCOVER ARE SET UP! 🎉"
colorEcho blue "\nYou can now run the app and API with: "
colorEcho green "              bash run.sh"