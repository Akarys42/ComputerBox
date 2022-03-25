set -e
source ./constants.sh

pushd ${SYSROOT} > /dev/null

echo ${STYLE_BOLD} PACKING INITRAMFS ${STYLE_RESET}
find . -print0 | cpio --null -ov --format=newc 2> /dev/null | gzip -9 > ${ROOT}/initramfs.cpio.gz

echo ${STYLE_2}Initramfs available at $(readlink -f ${ROOT}/initramfs.cpio.gz) ${STYLE_RESET}

popd > /dev/null