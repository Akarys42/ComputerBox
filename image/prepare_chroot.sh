#!/bin/bash
set -e
source ./constants.sh
source ./commons.sh

# Where do we mount the project folder in the chroot
BIND=${CHROOT}${ROOT}

function in_chroot() {
    ${SUDO} chroot ${CHROOT} /usr/bin/env $@
}

function mount_project() {
    echo ${STYLE_BOLD} MOUNTING PROJECT ROOT ${STYLE_RESET}

    ${SUDO} mkdir -p ${BIND}
    ${SUDO} mount --bind ${ROOT} ${BIND}

    echo ${STYLE_BOLD} MOUNTING SYSTEM DIRECTORIES ${STYLE_RESET}

    ${SUDO} mount --bind /dev ${CHROOT}/dev
    ${SUDO} mount --bind /proc ${CHROOT}/proc
    ${SUDO} mount --bind /sys ${CHROOT}/sys
}

if [ $1 == "mount" ]; then
    echo ${STYLE_BOLD} PREPARING CHROOT ${STYLE_RESET}
    if [ ! -d $CHROOT ]; then
        mkdir -p -v ${CHROOT}
        mkdir -p ${SYSROOT}
        mkdir -p ${DOWNLOADS}
        mkdir -p ${BUILD}

        echo ${STYLE_BOLD} DOWNLOADING APK TOOLS ${STYLE_RESET}
        download ${APK_TOOLS_DOWNLOAD} ${APK_TOOLS_FILE}
        echo ${STYLE_BOLD} EXTRACTING APK TOOLS ${STYLE_RESET}
        mkdir ${CHROOT}/apk_tools
        extract ${APK_TOOLS_FILE} ${CHROOT}/apk_tools/fakedir

        echo ${STYLE_BOLD} CREATING CHROOT ${STYLE_RESET}
        ${SUDO} ${CHROOT}/apk_tools/sbin/apk.static -X ${ALPINE_MIRROR}/latest-stable/main -U --allow-untrusted -p ${CHROOT} --initdb add alpine-base

        ${SUDO} cp -L /etc/resolv.conf ${CHROOT}/etc/
        ${SUDO} mkdir -p ${CHROOT}/etc/apk
        echo "${ALPINE_MIRROR}/latest-stable/main" | ${SUDO} tee -a ${CHROOT}/etc/apk/repositories > /dev/null
        echo "${ALPINE_MIRROR}/latest-stable/community" | ${SUDO} tee -a ${CHROOT}/etc/apk/repositories > /dev/null  # Required for rustup

        mount_project

        echo ${STYLE_BOLD} INSTALLING REQUIRED TOOLS ${STYLE_RESET}

        in_chroot apk add --no-cache ${ALPINE_PACKAGES}
        in_chroot adduser build-agent -u $(id -u) -g $(id -g) -G root --disabled-password || true
        in_chroot RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo rustup-init -y --default-toolchain none
        in_chroot mkdir -p /tmp
        in_chroot chown $(id -u):$(id -g) /tmp
    else
        echo ${STYLE_2}${CHROOT}${STYLE_RESET} already exists
        mount_project
    fi
elif [ $1 == "umount" ]; then
    if [ -d $CHROOT ]; then
        echo ${STYLE_BOLD} UNMOUNTING CHROOT ${STYLE_RESET}

        ${SUDO} umount ${CHROOT}/dev || true
        ${SUDO} umount ${CHROOT}/proc || true
        ${SUDO} umount ${CHROOT}/sys || true
        ${SUDO} umount ${BIND} || true
    else
        echo ${STYLE_2}${CHROOT}${STYLE_RESET} does not exist
    fi
else
    echo "Usage: $0 mount|umount"
fi