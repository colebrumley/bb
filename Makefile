ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
include config/build.conf

builder:
	docker build -t $(BUILDIMG) -f base.Dockerfile .

rootfs:
	docker run -it --rm -v $(ROOT_DIR):/out --env-file=config/build.conf $(TMPFS_BUILD) $(BUILDIMG)

image:
	docker build -t $(DISTIMG) -f img.Dockerfile .

clean:
	echo $(ROOT_DIR)
	docker rmi $(BUILDIMG) || true
	docker rmi $(DISTIMG) || true
	rm -f rootfs.tar.gz || true

all: builder rootfs image