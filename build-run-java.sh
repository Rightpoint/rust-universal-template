#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$SCRIPT_DIR"
cargo build --features "java" --release
# Compile Java
javac Source/Java/HelloWorld.java
# Generate C header JNI interface
javah -classpath Source/Java -d Source/Java HelloWorld
java -Djava.library.path=target/release -classpath Source/Java HelloWorld
