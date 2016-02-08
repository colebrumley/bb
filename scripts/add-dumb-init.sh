#!/bin/bash
filepath=/build/buildroot-${BUILDROOT_VERSION}/output/target/sbin/dumb-init
wget -O $filepath https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64
chmod a+x $filepath
mkdir -p /build/buildroot-${BUILDROOT_VERSION}/output/target/etc/service
