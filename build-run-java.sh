#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$SCRIPT_DIR"
echo "Building Rust code..."
cargo build --features "java" --release

echo "Running Java example..."
# Compile Java
javac Source/Java/HelloWorld.java
# Generate C header JNI interface
javah -classpath Source/Java -d Source/Java HelloWorld
javac Examples/Java/HelloWorld/Main.java -classpath Source/Java
java -Djava.library.path=target/release -classpath "Source/Java:Examples/Java/HelloWorld" Main

echo "Running gradle..."
./gradlew build
