#!/usr/bin/env bash

set -e

# The root of the project.
PRJ_ROOT="${PRJ_ROOT:-$(git rev-parse --show-toplevel)}"

cargo_build() {
  if ! command -v cargo &>/dev/null; then
    echo "Couldn't find cargo in \$PATH, make sure the Rust toolchain is installed"
    return 1
  fi
  cargo build --release 
  return 0
}

copy_stuff() {
  # extension is `.so` on linux, `.dylib` on macOS and `.dll` on Windows
  library_extension=$(\
    [ -f $PRJ_ROOT/target/release/liboxocarbon.so ] \
      && echo so \
      || echo dylib \
  )

  # Place the compiled library where Neovim can find it.
  mkdir -p $PRJ_ROOT/lua
  cp \
    "$PRJ_ROOT/target/release/liboxocarbon.$library_extension" \
    $PRJ_ROOT/lua/oxocarbon.so
}

cargo_build && copy_stuff
