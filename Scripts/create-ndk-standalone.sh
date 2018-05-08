#!/bin/sh
# Originally from https://github.com/kennytm/rust-ios-android
# https://github.com/kennytm/rust-ios-android/blob/d0b606167ba7835488d565a9c9cbfb789e61f1c9/create-ndk-standalone.sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
STANDALONE_NDK_DIR="$SCRIPT_DIR/../NDK"
DEFAULT_ANDROID_NDK="/usr/local/share/android-ndk"
DEFAULT_ANDROID_SDK="/usr/local/share/android-sdk"

if [ -d "$STANDALONE_NDK_DIR" ]; then
    printf '\033[33;1mStandalone NDK already exists... Delete the NDK folder if you want to make a new one.\033[0m\n\n'
    echo "    $ rm -rf \"${STANDALONE_NDK_DIR}\""
    exit 0
fi


# Try to find NDK if it's not set
if [ ! -d "${ANDROID_NDK_HOME}" ]; then
    if [ -d "${DEFAULT_ANDROID_NDK}" ]; then
        ANDROID_NDK_HOME="$DEFAULT_ANDROID_NDK"
        echo "ANDROID_NDK_HOME not set, using NDK found at ${DEFAULT_ANDROID_NDK}"
    else
        if [ ! -d "${ANDROID_SDK_ROOT}" ]; then
            ANDROID_SDK_ROOT="${DEFAULT_ANDROID_SDK}"
        fi
        if [ ! -d "${ANDROID_HOME}" ]; then
            ANDROID_HOME="$ANDROID_SDK_ROOT"
        fi
        if [ -d "${ANDROID_HOME}/ndk-bundle" ]; then
            ANDROID_NDK_HOME="${ANDROID_HOME}/ndk-bundle"
        fi
    fi
fi

if [ ! -d "${ANDROID_NDK_HOME}" ]; then
    echo "Error: Android NDK could not be found. Please set ANDROID_NDK_HOME to a valid Android NDK."
    exit 1
fi


MAKER="${ANDROID_NDK_HOME}/build/tools/make_standalone_toolchain.py"

if [ -x "$MAKER" ]; then
    echo 'Creating standalone NDK...'
else
    printf '\033[91;1mPlease install Android NDK!\033[0m\n\n'
    printf '  $ sdkmanager ndk-bundle\n\n'
    printf "\033[33;1mnote\033[0m: file \033[34;4m$MAKER\033[0m not found.\n"
    printf 'If you have installed the NDK in non-standard location, please define the \033[1m$ANDROID_NDK_HOME\033[0m variable.\n'
    exit 1
fi

mkdir STANDALONE_NDK_DIR

create_ndk() {
    echo "($1)..."
    "$MAKER" --api "$2" --arch "$1" --install-dir "$STANDALONE_NDK_DIR/$1"
}

create_ndk arm64 21
create_ndk arm 18
create_ndk x86 18
create_ndk x86_64 21
