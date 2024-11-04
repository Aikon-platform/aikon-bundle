#!/bin/bash

AIKON_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/aikon" >/dev/null 2>&1 && pwd )"
DISCOVER_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/discover-api" >/dev/null 2>&1 && pwd )"

AIKON_RUN="$AIKON_DIR/run.sh"
DISCOVER_RUN="$DISCOVER_DIR/run.sh"

aikon_pid=""
discover_pid=""

cleanup() {
    echo "Shutting down all processes..."
    [ -n "$aikon_pid" ] && kill "$aikon_pid"
    [ -n "$discover_pid" ] && kill "$discover_pid"
    wait
    echo "All processes terminated."
    exit 0
}

trap cleanup SIGINT SIGTERM

(cd "$AIKON_DIR" && bash "$AIKON_RUN") &
aikon_pid=$!

(cd "$DISCOVER_DIR" && bash "$DISCOVER_RUN") &
discover_pid=$!

wait
