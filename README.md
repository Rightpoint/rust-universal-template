# Rust Framework Template

Template for creating cross-platform Rust libraries as iOS/macOS/tvOS/watchOS Swift frameworks.

### Setup

Install Rust via Rustup

```bash
$ curl https://sh.rustup.rs -sSf | sh
```

If you want Bitcode support (required for tvOS and watchOS) you'll need to use a Rust nightly 1.2.7+ build (as of 4-27-2018).

```bash
$ rustup toolchain install nightly
$ rustup default nightly
```

Install the iOS targets for your selected toolchain:

```bash
$ rustup target add aarch64-apple-ios armv7-apple-ios armv7s-apple-ios  x86_64-apple-ios i386-apple-ios
```

Install `cargo-lipo`

```bash
$ cargo install cargo-lipo
```

#### Install Visual Studio Code (optional)

VS Code offers an IDE-like experiene for developing your Rust code, including some rough LLDB debugging support.

* [VS Code](https://code.visualstudio.com/)
  * [rls-vscode](https://github.com/rust-lang-nursery/rls-vscode) (code completion)
  * [vscode-lldb](https://github.com/vadimcn/vscode-lldb) (debugging)

### Structure

#### `src/`

The src folder contains all of our Rust library source code (`.rs`) and a manually created C header file (`example.h`) exporting a few symbols of interest from our Rust code. The build output is a static library called `libexample.a`.


#### `ExampleCore.framework`

This framework is a lightweight wrapper that simply includes the `libexample.a` library and `example.h` header. 


#### `ExampleSwift.framework`

This framework builds a higher level Swift API on top of `ExampleCore.framework`.

### Reference

* [cargo-lipo](https://github.com/TimNN/cargo-lipo) - Cargo subcommand to automatically create universal libraries for iOS.
* [rust-to-ios](https://github.com/wojteklu/rust-to-ios) - Example project for building a library for iOS in Rust.
* [rust-ios-android](https://github.com/kennytm/rust-ios-android) - Example project for building Rust library for iOS and Android

### License

MIT