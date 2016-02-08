FROM scratch
MAINTAINER Cole Brumley <github.com/colebrumley>
ADD rootfs.tar.gz /
ENTRYPOINT ["/sbin/dumb-init"]
CMD ["-c", "runsvdir", "/etc/service"]