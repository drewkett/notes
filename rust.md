# Rust 
## Parsing Libraries
- [nom](https://github.com/Geal/nom)
- [nom-packrat](https://github.com/dalance/nom-packrat)
  - Speeds up nom at the expense of memory usage
- [combine](https://github.com/Marwes/combine) 
  > "An implementation of parser combinators for Rust, inspired by the Haskell library Parsec"
  - Never used it
  
- [Benchmarks](https://github.com/rust-bakery/parser_benchmarks/)

## Miscellaneous
Get version number in code from cargo.toml
```
let version = env!("CARGO_PKG_VERSION");
```
