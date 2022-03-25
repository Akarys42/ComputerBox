set -e
source ./constants.sh

pushd ${KERNEL_BUILD} > /dev/null

echo ${STYLE_BOLD} CONFIGURING KERNEL ${STYLE_RESET}
make defconfig

echo ${STYLE_BOLD} BUILDING KERNEL ${STYLE_RESET}
make -j$(nproc)

popd > /dev/null