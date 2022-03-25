set -e
source ./constants.sh

pushd ${KERNEL_BUILD} > /dev/null

echo ${STYLE_BOLD} COPYING KERNEL ${STYLE_RESET}
cp arch/x86_64/boot/bzImage ${ROOT}/vmlinuz

echo ${STYLE_2}Kernel available at $(readlink -f ${ROOT}/vmlinuz) ${STYLE_RESET}

popd > /dev/null