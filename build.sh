#! /bin/bash
set -e

(cd build; make install)

./wasi-sdk-16.0/bin/clang -Wl,--export-all -Wl,--no-entry -mexec-model=reactor -I$(pwd)/install/include -L$(pwd)/install/lib -lmbedcrypto -lmbedx509 -lmbedtls -o mbedtls.wasm mbedtls.c
