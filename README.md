# Rust Universal Template

Template for creating universal Rust libraries with bindings to iOS/macOS (Swift), Android (Java/JNI), JavaScript (WebAssembly), and more.

### Goals

- [ ] iOS / macOS
	- [x] Swift Framework template
	- [x] Run `cargo` via Xcode External Build System
	- [ ] Carthage support
	- [ ] CocoaPods support
	- [ ] Automated Rust => Swift binding generation
	- [ ] Example app
- [ ] Android / Java
	- [ ] Gradle library template
	- [ ] Automated Rust => Java/JNI binding generation
	- [ ] Example app	
- [ ] Web Browsers / JavaScript
	- [ ] JavaScript / WebAssembly template
	- [ ] Automated Rust => JavaScript binding generation ([wasm-bindgen](https://github.com/rustwasm/wasm-bindgen))
	- [ ] Example app
- [ ] General
	- [ ] Automated Rust => C binding generation ([cbindgen](https://github.com/eqrion/cbindgen/))
	- [ ] Create [cookiecutter](https://github.com/audreyr/cookiecutter) template
	- [ ] Documention and examples for best practices when using Rust from other languages

### Setup

Install Rust via Rustup:

```bash
$ curl https://sh.rustup.rs -sSf | sh
```

If you want Bitcode support you'll need to use a Rust nightly 1.2.7+ build (as of 4-27-2018):

```bash
$ rustup toolchain install nightly
$ rustup default nightly
```

#### iOS

Install the iOS targets for your selected toolchain:

```bash
$ rustup target add aarch64-apple-ios armv7-apple-ios armv7s-apple-ios  x86_64-apple-ios i386-apple-ios
```

Install `cargo-lipo` for generating universal iOS libraries:

```bash
$ cargo install cargo-lipo
```

#### Android

Install [Android NDK](https://developer.android.com/ndk/):

```
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

#### Install Visual Studio Code (optional)

VS Code offers an IDE-like experiene for developing your Rust code, including some rough LLDB debugging support.

* [VS Code](https://code.visualstudio.com/)
  * [rls-vscode](https://github.com/rust-lang-nursery/rls-vscode) (code completion)
  * [vscode-lldb](https://github.com/vadimcn/vscode-lldb) (debugging)

### Structure

#### `Source/Rust`

The src folder contains all of our Rust library source code (`.rs`) and a manually created C header file (`example.h`) exporting a few symbols of interest from our Rust code. The build output is a static library called `libexample.a`.

#### `ExampleCore.framework`

This iOS/macOS framework is a lightweight wrapper that simply includes the `libexample.a` library and `example.h` header. 


#### `ExampleSwift.framework`

This iOS/macOS framework builds a higher level Swift API on top of `ExampleCore.framework`.

### Reference

* [cargo-lipo](https://github.com/TimNN/cargo-lipo) - Cargo subcommand to automatically create universal libraries for iOS.
* [rust-to-ios](https://github.com/wojteklu/rust-to-ios) - Example project for building a library for iOS in Rust.
* [rust-ios-android](https://github.com/kennytm/rust-ios-android) - Example project for building Rust library for iOS and Android
* [rust_on_mobile](https://github.com/Geal/rust_on_mobile) - iOS and Android examples
* [cbindgen](https://github.com/eqrion/cbindgen/) - A project for generating C bindings from Rust code
* [wasm-bindgen](https://github.com/rustwasm/wasm-bindgen) - Interoperating JavaScript and Rust
* [rust-bindgen](https://github.com/rust-lang-nursery/rust-bindgen) - Automatically generates Rust FFI bindings to C (and some C++) libraries
* [JavaScript to Rust and Back Again: A wasm-bindgen Tale](https://hacks.mozilla.org/2018/04/javascript-to-rust-and-back-again-a-wasm-bindgen-tale/)

### License

MIT