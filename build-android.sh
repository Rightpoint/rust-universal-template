#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NDK_DIR="$SCRIPT_DIR/NDK"

# Check for standalone NDK

if [ ! -d "$NDK_DIR" ]; then
    echo "Standalone NDK not found, running create-ndk-standalone.sh"
    sh "Scripts/create-ndk-standalone.sh"
fi

if [ ! -d "$NDK_DIR" ]; then
    echo "Error: Could not find standalone NDK"
    exit 1
fi

# Add clang/gcc binaries to PATH
PATH="$NDK_DIR/arm/bin:$PATH"
PATH="$NDK_DIR/arm64/bin:$PATH"
PATH="$NDK_DIR/x86/bin:$PATH"
PATH="$NDK_DIR/x86_64/bin:$PATH"

cd "$SCRIPT_DIR"
cargo build --target armv7-linux-androideabi --release
cargo build --target aarch64-linux-android --release
cargo build --target i686-linux-android --release
cargo build --target x86_64-linux-android --release
