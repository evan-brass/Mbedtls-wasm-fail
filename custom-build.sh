#! /bin/bash
set -e

clang --target=wasm32 -I$(pwd)/vendor/include -I$(pwd)/wasi-sdk-16.0/share/wasi-sysroot/include -o obj/psa_crypto_aead.o vendor/library/psa_crypto_aead.c
