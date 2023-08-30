#!/usr/bin/env bash

set -x

PKGBUILD=$(date '+%y%m%d%H%M%S')
# SRC=$(pwd)

INSTALL_DIR=$(readlink install)
BUILD=$(basename -s .install "${INSTALL_DIR}")

PACKAGE_NAME=kmscube-fixed
PACKAGE_VERSION=0.0.1

rm -rf "${INSTALL_DIR}/DEBIAN"
mkdir "${INSTALL_DIR}/DEBIAN"

cat <<EOF > "${INSTALL_DIR}/DEBIAN/control"
Package: ${PACKAGE_NAME}
Version: ${PACKAGE_VERSION}-${BUILD}.${PKGBUILD}
Section: base
Depends: libgstreamer1.0-0 (>= 1.16.3), gstreamer1.0-plugins-base (>= 1.16.3),
	gstreamer1.0-plugins-good (>= 1.16.3), gstreamer1.0-plugins-bad (>= 1.16.3),
	gstreamer1.0-plugins-ugly (>= 1.16.2), libgbm1 (>= 21.2.6),
	libegl1 (>= 1.3.2), libgles2 (>= 1.3.2), libgl1-mesa-dri (>= 21.2.6)
Priority: optional
Architecture: amd64
Maintainer: Aleksei Makarov <alm@opensynergy.com>
Description: kmscube fixed for video
EOF


FILENAME=./xchg/"${PACKAGE_NAME}_${PACKAGE_VERSION}-${BUILD}.${PKGBUILD}.deb"
rm -f ./xchg/"${PACKAGE_NAME}"*.deb
dpkg-deb --build "${INSTALL_DIR}" "${FILENAME}"
