# `bb` - **Just a _little_ more than BusyBox**

## What is `elcolio/bb`?
This is a quasi-minimal BusyBox rootfs with some basic utilities added for flexible yet minimal Docker images. I say _quasi_-minimal because the goal is to support just enough shell utilities to enable effective scripting while keeping out as much cruft as possible. As a result this image clocks in at **18.57MB**, but comes with many of the utilities that keep the smaller, more basic [library BusyBox image](https://hub.docker.com/_/busybox/) from being quite as useful.

## Features
 - Uses Yelp's [dumb-init](https://github.com/Yelp/dumb-init) as the `ENTRYPOINT` to make sure PID1 is correctly managed
 - OpenSSL, OpenSSH, and root CA certificates pre-installed
 - `curl`, `wget`, and `jq` for API queries
 - [runit](http://smarden.org/runit/index.html) for handling multiple processes
   - The default `CMD` is `runsvdir /etc/service`, so any configured `runit` services start automatically
   - Specifying a `CMD` will skip `runit`
 - Several editors (`uemacs`, `vi`, `nano`) because I don't know which one you like
 - Based on `glibc`, so it can run non-statically linked Go binaries among other things (see the `musl`-based Alpine Linux for an even smaller base image with a package manager if `glibc` isn't important to you)

## Build + Customize
**To build:** To build the default image, run `make all`. You can build individual components with `make builder|rootfs|image`. To speed things up, you can use Docker v1.10's tmpfs mounts to store the buildroot directories (enable in `config/build.conf`). You'll need lots of RAM though, the tmpfs mount will need about 4GB depending on your selections.

Since this is Buildroot, the build will take approximately one eternity.

**To customize:** Put your custom Buildroot and BusyBox configs in the `config/` dir (replacing the existing ones). Modify `config/build.conf` to change the Buildroot version, tmpfs settings and resulting image names. For anything bigger please consider submitting a PR - sharing is caring.
