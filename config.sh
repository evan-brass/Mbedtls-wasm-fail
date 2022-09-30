#! /bin/bash
cmake \
	-D WASI_SDK_PREFIX=$(pwd)/wasi-sdk-16.0 \
	-D CMAKE_TOOLCHAIN_FILE=$(pwd)/wasi-sdk.cmake \
	-D CMAKE_C_FLAGS="-DMBEDTLS_USER_CONFIG_FILE=\\\"$(pwd)/user-config.h\\\"" \
	-D CMAKE_INSTALL_PREFIX=$(pwd)/install \
	-D ENABLE_PROGRAMS=OFF \
	-D ENABLE_TESTING=OFF \
	-D MBEDTLS_FATAL_WARNINGS=OFF \
	-S vendor -B build
