#!/bin/bash
set -e
cd image

source ./constants.sh

if [ "$1" == "--continue" ]; then
  shift
  echo ${STYLE_BOLD} STARTING BUILD ${STYLE_RESET}

  for script in $(ls | grep '^[0-9]*_.*.sh'); do
    if [ ${script:0:2} -ge ${1:-0} ]; then
      ./$script
    fi
  done

  echo ${STYLE_BOLD} BUILD COMPLETE ${STYLE_RESET}
else
  trap "./prepare_chroot.sh umount" EXIT
  ./prepare_chroot.sh mount

  ${SUDO} chroot ${CHROOT} /bin/sh -c "sudo -u \#$(id -u) /bin/sh -c 'cd ${ROOT} && ./build.sh --continue $1'"
fi