# Rust 
## Parsing Libraries
- [nom](https://github.com/Geal/nom)
- [nom-packrat](https://github.com/dalance/nom-packrat)
  - Speeds up nom at the expense of memory usage
- [combine](https://github.com/Marwes/combine) 
  > "An implementation of parser combinators for Rust, inspired by the Haskell library Parsec"
  - Never used it
  
[Benchmarks](https://github.com/rust-bakery/parser_benchmarks/)

## Python Interaction
### [PyO3](https://docs.rs/pyo3/)
Can be used for creating rust shared libraries that can be loaded into python as modules. Worked well for my use case.

Ran into an issue that I never fully tracked down where on import of rust library into python, python would crash. Not sure where this came from. 

Requires nightly rust

## Miscellaneous
### Version Number
Get version number in code from cargo.toml
```
let version = env!("CARGO_PKG_VERSION");
```
### Clean up
target folder can grow very large over time. Periodically delete it to free up disk space. 

## Libraries to Try
- [bstr](https://github.com/BurntSushi/bstr) - Bring string types to [u8] types
- [im](https://docs.rs/crate/im) - Immutable data structures
- [inline_python](https://docs.rs/inline-python) - Write python in rust code using a macro
  - Provides type interop using PyO3
- [uom](https://docs.rs/uom) - Add units to types for engineering calculations
