KERNEL_VERSION=5.15.31
MUSL_VERSION=1.2.2
BUSYBOX_VERSION=1.35.0
LIBCAP_VERSION=2.63
MINIJAIL_VERSION=17

SYSROOT=$(readlink -f ./sysroot)
ROOT=$(readlink -f ..)

BUILD=$(readlink -f ./build)
DOWNLOADS=$(readlink -f ./downloads)

KERNEL_BUILD=${BUILD}/linux-${KERNEL_VERSION}
MUSL_BUILD=${BUILD}/musl-${MUSL_VERSION}
BUSYBOX_BUILD=${BUILD}/busybox-${BUSYBOX_VERSION}
LIBCAP_BUILD=${BUILD}/libcap-${LIBCAP_VERSION}
MINIJAIL_BUILD=${BUILD}/minijail-linux-v${MINIJAIL_VERSION}

KERNEL_FILE=${DOWNLOADS}/linux-${KERNEL_VERSION}.tar.xz
MUSL_FILE=${DOWNLOADS}/musl-${MUSL_VERSION}.tar.gz
BUSYBOX_FILE=${DOWNLOADS}/busybox-${BUSYBOX_VERSION}.tar.bz2
LIBCAP_FILE=${DOWNLOADS}/libcap-cap_v${LIBCAP_VERSION}.tar.gz
MINIJAIL_FILE=${DOWNLOADS}/minijail-v${MINIJAIL_VERSION}.tar.gz

KERNEL_DOWNLOAD=https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-${KERNEL_VERSION}.tar.xz
BUSYBOX_DOWNLOAD=https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2
MUSL_DOWNLOAD=https://www.musl-libc.org/releases/musl-${MUSL_VERSION}.tar.gz
LIBCAP_DOWNLOAD=https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${LIBCAP_VERSION}.tar.xz
MINIJAIL_DOWNLOAD=https://github.com/google/minijail/archive/refs/tags/linux-v${MINIJAIL_VERSION}.tar.gz

STYLE_BOLD=$(tput bold)
STYLE_1=$(tput setaf 1)
STYLE_2=$(tput setaf 2)
STYLE_RESET=$(tput sgr0)