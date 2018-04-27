# Rust Framework Template

Template for creating cross-platform Rust libraries as iOS/macOS/tvOS/watchOS frameworks.

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

### Reference

* [cargo-lipo](https://github.com/TimNN/cargo-lipo) - Cargo subcommand to automatically create universal libraries for iOS.
* [rust-to-ios](https://github.com/wojteklu/rust-to-ios) - Example project for building a library for iOS in Rust.