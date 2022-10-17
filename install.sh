#!/usr/bin/env bash

set -e

NVIM_VERSION=$(nvim --version)
NVIM_VERSION=$(echo "$NVIM_VERSION" | head -n 1 | sed -e 's/^NVIM v//')
MINOR_VERSION=$(echo "$NVIM_VERSION" | cut -d '.' -f 2)

if [ $MINOR_VERSION = "7" ]; then
    cargo build --release --features neovim-0-7
fi

if [ $MINOR_VERSION = "8" ]; then
    cargo build --release --features neovim-0-8
fi

if [ $MINOR_VERSION -gt 8 ]; then
    cargo build --release --features neovim-nightly
fi

# Place the compiled library where Neovim can find it.
mkdir -p lua

if [ "$(uname)" == "Darwin" ]; then
    mv target/release/liboxocarbon.dylib lua/oxocarbon.so
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    mv target/release/liboxocarbon.so lua/oxocarbon.so
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    mv target/release/oxocarbon.dll lua/oxocarbon.dll
fi

