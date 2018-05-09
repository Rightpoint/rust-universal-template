# Rust Universal Template

[![Swift 4.1](https://img.shields.io/badge/Swift-4.1-orange.svg?style=flat)](https://swift.org)
[![Rustc Version 1.25+](https://img.shields.io/badge/rustc-1.25+-lightgray.svg?style=flat)](https://www.rust-lang.org/en-US/)
[![CircleCI](https://img.shields.io/circleci/project/github/Raizlabs/rust-universal-template/master.svg)](https://circleci.com/gh/Raizlabs/rust-universal-template)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


Template for creating universal Rust libraries with bindings to iOS/macOS (Swift), Android (Java/JNI), JavaScript (WebAssembly), and more.

## Goals

- [ ] iOS / macOS
	- [x] Swift Framework template
	- [x] Run `cargo` via Xcode External Build System
	- [x] Carthage support
	- [ ] CocoaPods support
	- [ ] Automated Rust => Swift binding generation
	- [x] Example iOS app
- [ ] Android / Java
	- [ ] Gradle library template
	- [ ] Automated Rust => Java/JNI binding generation
	- [x] Pure Java example
	- [ ] Example Android app
- [ ] Web Browsers / JavaScript
	- [ ] JavaScript / WebAssembly template
	- [ ] Automated Rust => JavaScript binding generation ([wasm-bindgen](https://github.com/rustwasm/wasm-bindgen))
	- [ ] Example app
- [ ] General
	- [ ] Automated Rust => C binding generation ([cbindgen](https://github.com/eqrion/cbindgen/))
	- [ ] Create [cookiecutter](https://github.com/audreyr/cookiecutter) template
	- [ ] Documention and examples for best practices when using Rust from other languages

## Setup

Install Rust via [Rustup](https://rustup.rs/):

```bash
$ curl https://sh.rustup.rs -sSf | sh
```

Make sure the Rust binaries are added to your `PATH` (e.g. inside `~/.profile`). This is usually performed automatically for you by `rustup`.

```bash
export PATH="$HOME/.cargo/bin:$PATH"
```

### iOS

Install the iOS targets for your selected toolchain:

```bash
$ rustup target add aarch64-apple-ios armv7-apple-ios x86_64-apple-ios i386-apple-ios
```

Install `cargo-lipo` for generating universal iOS libraries:

```bash
$ cargo install cargo-lipo
```

#### Bitcode

If you want Bitcode support you'll need to use a Rust nightly 1.2.7+ build (as of 4-27-2018). Unfortunately there still seems to be some issues with Bitcode so it is disabled for now. For more information see issue https://github.com/rust-lang/rust/issues/35968.

```bash
$ rustup toolchain install nightly
$ rustup target add aarch64-apple-ios armv7-apple-ios x86_64-apple-ios i386-apple-ios --toolchain nightly
$ rustup default nightly
```


### Android

Install [Android NDK](https://developer.android.com/ndk/) (tested on version r16b):

```bash
$ brew cask install android-ndk
```

Add `ANDROID_NDK_HOME` to your bash profile (e.g. `~/.profile`):

```bash
export ANDROID_NDK_HOME="/usr/local/share/android-ndk"
```

Install Android Rust targets:

```
$ rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
```

Run `build-android.sh`. This will create a standalone NDK toolchain and in the `NDK` directory if needed, and then run `cargo build` for all Android targets.

```
$ ./build-android.sh
```

### Java

To regenerate the Java JNI bindings, you need to first compile the Java with `javac` and then run `javah` to generate a C header. This generated header `HelloWorld.h` shows us the expected method signature for the JNI function.

```bash
# Compile Java
$ javac Source/Java/HelloWorld.java
# Generate C header JNI interface
$ javah -classpath Source/Java -d Source/Java HelloWorld
```

The corresponding Rust source code can be found in `Source/Rust/java/src/lib.rs`. We must first compile it, so the output shared library (`libexample.dylib` on macOS) can be found by Java.

```bash
$ cargo build --features "java" --release
```

Finally, we can run our Java code that calls into the Rust code:

```bash
$ java -Djava.library.path=target/release -classpath Source/Java HelloWorld
Hello, from Rust!!
```

### Install Visual Studio Code (optional)

VS Code offers an IDE-like experiene for developing your Rust code, including some rough LLDB debugging support.

* [VS Code](https://code.visualstudio.com/)
  * [rls-vscode](https://github.com/rust-lang-nursery/rls-vscode) (code completion)
  * [vscode-lldb](https://github.com/vadimcn/vscode-lldb) (debugging)

## Structure

### `Source/Rust`

The src folder contains all of our Rust library source code (`.rs`) and a manually created C header file (`example.h`) exporting a few symbols of interest from our Rust code. The build output is a static library called `libexample.a`.

### `ExampleObjC.framework`

This iOS/macOS framework contains a Objective-C wrapper around the the C interface exposed by `example.h`.

### `ExampleSwift.framework`

This iOS/macOS framework contains a Swift wrapper around the the C interface exposed by `example.h`.

## Reference

### Tools

* [cargo-lipo](https://github.com/TimNN/cargo-lipo) - Cargo subcommand to automatically create universal libraries for iOS.
* [cbindgen](https://github.com/eqrion/cbindgen/) - A project for generating C bindings from Rust code
* [wasm-bindgen](https://github.com/rustwasm/wasm-bindgen) - Interoperating JavaScript and Rust
* [rust-bindgen](https://github.com/rust-lang-nursery/rust-bindgen) - Automatically generates Rust FFI bindings to C (and some C++) libraries

### Examples

* [cross-platform-rust](https://github.com/fluffyemily/cross-platform-rust) - Example project showing a Rust library running on iOS and Android
* [rust-to-ios](https://github.com/wojteklu/rust-to-ios) - Example project for building a library for iOS in Rust.
* [rust-ios-android](https://github.com/kennytm/rust-ios-android) - Example project for building Rust library for iOS and Android
* [rust_on_mobile](https://github.com/Geal/rust_on_mobile) - iOS and Android examples

### Articles

* [JavaScript to Rust and Back Again: A wasm-bindgen Tale](https://hacks.mozilla.org/2018/04/javascript-to-rust-and-back-again-a-wasm-bindgen-tale/)
* [Building and Deploying a Rust library on Android](https://mozilla.github.io/firefox-browser-architecture/experiments/2017-09-21-rust-on-android.html)
* [Building and Deploying a Rust library on iOS](https://mozilla.github.io/firefox-browser-architecture/experiments/2017-09-06-rust-on-ios.html)
* [Building for Android](https://github.com/servo/servo/wiki/Building-for-Android) - Servo's Android toolchain setup
* [Taking Rust everywhere with rustup](https://blog.rust-lang.org/2016/05/13/rustup.html)

## License

MIT