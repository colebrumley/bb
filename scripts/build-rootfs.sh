#!/bin/bash
set -e
BUILDROOT_TARFILE=buildroot-${BUILDROOT_VERSION}.tar.gz
BUILDROOT_URL=https://buildroot.org/downloads/$BUILDROOT_TARFILE

echo "Getting Buildroot tar"
wget -O $BUILDROOT_TARFILE $BUILDROOT_URL
echo

echo "Extracting Buildroot"
tar -xvf $BUILDROOT_TARFILE; rm $BUILDROOT_TARFILE
cd buildroot-${BUILDROOT_VERSION}
echo

echo "Moving Buildroot config files"
cp /build/config/buildroot.config \
    /build/buildroot-${BUILDROOT_VERSION}/.config
mkdir -p /build/buildroot-${BUILDROOT_VERSION}/package/busybox/ || true
cp /build/config/busybox.config \
	/build/buildroot-${BUILDROOT_VERSION}/package/busybox/busybox.config
echo

echo "Running build"
make
echo

echo "Moving build results to /out"
mkdir -p /out || true
cp output/images/rootfs.tar.gz /out/
echo

echo "DONE!"