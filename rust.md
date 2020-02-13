# Rust

## Parsing Libraries

- [nom](https://github.com/Geal/nom)
- [nom-packrat](https://github.com/dalance/nom-packrat)
  - Speeds up nom at the expense of memory usage
- [combine](https://github.com/Marwes/combine)

  > "An implementation of parser combinators for Rust, inspired by the Haskell
  > library Parsec"

  - Never used it

[Benchmarks](https://github.com/rust-bakery/parser_benchmarks/)

## Python Interaction

### [PyO3](https://docs.rs/pyo3/)

Can be used for creating rust shared libraries that can be loaded into python as
modules. Worked well for my use case.

Ran into an issue that I never fully tracked down where on import of rust
library into python, python would crash. Not sure where this came from.

Requires nightly rust

## Miscellaneous

### Version Number

Get version number in code from cargo.toml

```
let version = env!("CARGO_PKG_VERSION");
```

### Clean up

target folder can grow very large over time. Periodically delete it to free up
disk space.

### Struct Definitions based on JSON Samples

[Web Tool](https://typegen.vestera.as/)
[Library](https://crates.io/crates/json_typegen)

## Libraries to Try

- [bstr](https://github.com/BurntSushi/bstr) - Bring string types to [u8] types
- [im](https://docs.rs/crate/im) - Immutable data structures
- [inline_python](https://docs.rs/inline-python) - Write python in rust code
  using a macro
  - Provides type interop using PyO3
- [uom](https://docs.rs/uom) - Add units to types for engineering calculations

## Cross Compilation

To cross compile you need a compiler that can generate compatible binaries with
the target platform

This article discusses a few different strategies

[http://timryan.org/2018/07/27/cross-compiling-linux-binaries-from-macos.html](http://timryan.org/2018/07/27/cross-compiling-linux-binaries-from-macos.html)

### Mac to Linux

#### libc

[https://github.com/SergioBenitez/homebrew-osxct](https://github.com/SergioBenitez/homebrew-osxct)

Not sure all the environment variables with pwd are needed/working since it
seems like it should be run as root

    brew tap SergioBenitez/osxct
    brew install x86_64-unknown-linux-gnu

    rustup target add x86_64-unknown-linux-gnu

    # Linker for the target platform
    # (cc can also be updated using .cargo/config)
    export TARGET_CC="x86_64-unknown-linux-gnu-gcc"


    ### in .cargo/config
    [target.x86_64-unknown-linux-gnu]
    linker = "x86_64-linux-gnu-gcc"
    ###

    # Not sure about the standalone. I didn't use it and it seemed to work fine
    cargo build --target=x86_64-unknown-linux-gnu --features 'standalone'

- If Openssl is needed to link against (from a dependency)

#### musl

[https://blog.filippo.io/easy-windows-and-linux-cross-compilers-for-macos/](https://blog.filippo.io/easy-windows-and-linux-cross-compilers-for-macos/)

    brew install FiloSottile/musl-cross/musl-cross

    #### in .cargo/config
    [target.x86_64-unknown-linux-musl]
    linker = "x86_64-linux-musl-gcc"
    ####

    ### Needed because c code compiled by rust will use the default? c compiler
    export TARGET_CC=x86_64-linux-musl-gcc

### Docker

could also set up docker and compile inside container
