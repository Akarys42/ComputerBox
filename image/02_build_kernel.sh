set -e
source ./constants.sh

pushd ${KERNEL_BUILD} > /dev/null

echo ${STYLE_BOLD} CONFIGURING KERNEL ${STYLE_RESET}
make defconfig
${UPDATE_CONFIG} CONFIG_FUSE_FS=y CONFIG_CUSE=y CONFIG_VIRTIO_FS=n

echo ${STYLE_BOLD} BUILDING KERNEL ${STYLE_RESET}
make -j$(nproc)

popd > /dev/null