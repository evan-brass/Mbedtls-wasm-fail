#! /bin/bash
rm -rf build install

cmake \
	-D WASI_SDK_PREFIX=$(pwd)/wasi-sdk-16.0 \
	-D CMAKE_TOOLCHAIN_FILE=$(pwd)/wasi-sdk.cmake \
	-D DLEXT=wasm \
	-D CMAKE_C_FLAGS="-DMBEDTLS_USER_CONFIG_FILE=\\\"$(pwd)/user-config.h\\\" -mexec-model=reactor --sysroot $(pwd)/wasi-sdk-16.0/share/wasi-sysroot" \
	-D USE_SHARED_MBEDTLS_LIBRARY=ON \
	-D CMAKE_SHARED_LINKER_FLAGS="--no-entry" \
	-D CMAKE_INSTALL_PREFIX=$(pwd)/install \
	-D ENABLE_PROGRAMS=OFF \
	-D ENABLE_TESTING=OFF \
	-D MBEDTLS_FATAL_WARNINGS=OFF \
	-S vendor -B build
