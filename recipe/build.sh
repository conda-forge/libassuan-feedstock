#!/usr/bin/env bash
set -e -o pipefail -x

if [[ $CONDA_BUILD_CROSS_COMPILATION == 1 && $target_platform == osx-arm64 ]]; then
	# Get an updated config.sub and config.guess
	cp -v $BUILD_PREFIX/share/gnuconfig/config.* ./build-aux
fi

if [[ "${target_platform}" == osx-* ]]; then
    export CFLAGS="$CFLAGS -std=c89"
fi

autoreconf -if
./configure --prefix=$PREFIX
make
make install
