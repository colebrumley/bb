ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
include config/build.conf

builder:
	docker build -t $(BUILDIMG) -f base.Dockerfile .

rootfs:
	docker run -it \
	-v $(ROOT_DIR):/out \
	-e DISTIMG=$(DISTIMG) \
	-e BUILDROOT_VERSION=$(BUILDROOT_VERSION) \
	-e LC_ALL=$(LC_ALL) \
	$(TMPFS_BUILD) $(BUILDIMG)

image:
	docker build -t $(DISTIMG) -f img.Dockerfile .

clean:
	docker rmi $(BUILDIMG) || true
	docker rmi $(DISTIMG) || true
	rm -f rootfs.tar.gz || true

all: builder rootfs image

ci: clean all