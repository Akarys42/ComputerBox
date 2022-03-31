APK_TOOLS_VERSION=2.12.7-r3
KERNEL_VERSION=5.15.31
MUSL_VERSION=1.2.2
BUSYBOX_VERSION=1.35.0
LIBCAP_VERSION=2.63
MINIJAIL_VERSION=17
FUSE_VERSION=2.9.9

# Default parameters
SUDO=${SUDO:-sudo}
ALPINE_MIRROR=${ALPINE_MIRROR:-http://dl-cdn.alpinelinux.org/alpine}

ALPINE_PACKAGES="bash bison build-base diffutils elfutils-dev findutils flex linux-headers musl-dev ncurses openssl-dev perl python3 rsync rustup xz"

ROOT=$(readlink -f ..)
IMAGE=${ROOT}/image

CHROOT=/tmp/computerbox-build-chroot

SYSROOT=${IMAGE}/sysroot
UPDATE_CONFIG=${IMAGE}/update_config.py

BUILD=${IMAGE}/build
DOWNLOADS=${IMAGE}/downloads

KERNEL_BUILD=${BUILD}/linux-${KERNEL_VERSION}
MUSL_BUILD=${BUILD}/musl-${MUSL_VERSION}
BUSYBOX_BUILD=${BUILD}/busybox-${BUSYBOX_VERSION}
LIBCAP_BUILD=${BUILD}/libcap-${LIBCAP_VERSION}
MINIJAIL_BUILD=${BUILD}/minijail-linux-v${MINIJAIL_VERSION}
FUSE_BUILD=${BUILD}/fuse-${FUSE_VERSION}
CONTROLLER_BUILD=${ROOT}/controller

APK_TOOLS_FILE=${DOWNLOADS}/apk-tools-static-2.9.0-r0.apk
KERNEL_FILE=${DOWNLOADS}/linux-${KERNEL_VERSION}.tar.xz
MUSL_FILE=${DOWNLOADS}/musl-${MUSL_VERSION}.tar.gz
BUSYBOX_FILE=${DOWNLOADS}/busybox-${BUSYBOX_VERSION}.tar.bz2
LIBCAP_FILE=${DOWNLOADS}/libcap-cap_v${LIBCAP_VERSION}.tar.gz
MINIJAIL_FILE=${DOWNLOADS}/minijail-v${MINIJAIL_VERSION}.tar.gz
FUSE_FILE=${DOWNLOADS}/fuse-${FUSE_VERSION}.tar.gz

APK_TOOLS_DOWNLOAD=${ALPINE_MIRROR}/latest-stable/main/x86_64/apk-tools-static-${APK_TOOLS_VERSION}.apk
KERNEL_DOWNLOAD=https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-${KERNEL_VERSION}.tar.xz
BUSYBOX_DOWNLOAD=https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2
MUSL_DOWNLOAD=https://www.musl-libc.org/releases/musl-${MUSL_VERSION}.tar.gz
LIBCAP_DOWNLOAD=https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${LIBCAP_VERSION}.tar.xz
MINIJAIL_DOWNLOAD=https://github.com/google/minijail/archive/refs/tags/linux-v${MINIJAIL_VERSION}.tar.gz
FUSE_DOWNLOAD=https://github.com/libfuse/libfuse/releases/download/fuse-${FUSE_VERSION}/fuse-${FUSE_VERSION}.tar.gz

STYLE_BOLD=$(tput bold)
STYLE_1=$(tput setaf 1)
STYLE_2=$(tput setaf 2)
STYLE_RESET=$(tput sgr0)