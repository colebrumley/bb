FROM    ubuntu:14.04
ENV     DEBIAN_FRONTEND noninteractive
RUN     apt-get update && \
        apt-get install -y \
            build-essential \
            tar \
            wget \
            libncurses5-dev \
            unzip \
            bc \
            curl \
            python \
            rsync \
            ccache \
            git \
            vim \
            locales \
            gcc-multilib \
            libssl-dev && \
        locale-gen --lang en_US.UTF-8

COPY    scripts/* /build/
COPY    config /build/config

WORKDIR /build
VOLUME  /out
CMD     ["/build/build-rootfs.sh"]
