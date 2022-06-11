set -e
source ./constants.sh

pushd ${KERNEL_BUILD} > /dev/null

echo ${STYLE_BOLD} CONFIGURING KERNEL ${STYLE_RESET}
# make defconfig && exit 1
cp -v ${ROOT}/image/kernel_config ./.config

echo ${STYLE_BOLD} BUILDING KERNEL ${STYLE_RESET}
make LLVM=1 LLVM_IAS=1 -j$(nproc)

popd > /dev/null