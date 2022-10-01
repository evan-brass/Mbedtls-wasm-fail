#! /bin/bash
set -e

(cd build; make install)

clang -Wl,--export-all -Wl,--no-entry -I$(pwd)/install/include -L$(pwd)/install/lib -lmbedcrypto -lmbedx509 -lmbedtls -o mbedtls.wasm mbedtls.c
