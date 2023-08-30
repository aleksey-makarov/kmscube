#!/usr/bin/env bash

DATE=$(date '+%y%m%d%H%M%S')
PWD=$(pwd)

INSTALL_DIR=$PWD/$DATE.install
BUILD_DIR=$PWD/$DATE.build

echo "install: $INSTALL_DIR, build: $BUILD_DIR"

mkdir -p "$INSTALL_DIR"
meson "$BUILD_DIR" --prefix="$INSTALL_DIR"

ln -fs -T "$INSTALL_DIR" install
ln -fs -T "$BUILD_DIR"    build

meson install -C "$BUILD_DIR"
