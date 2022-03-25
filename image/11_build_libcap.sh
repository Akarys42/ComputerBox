set -e
source ./constants.sh

pushd ${LIBCAP_BUILD} > /dev/null

# echo ${STYLE_BOLD} CONFIGURING BUSYBOX ${STYLE_RESET}
# make defconfig > /dev/null

echo ${STYLE_BOLD} BUILDING LIBCAP_BUILD ${STYLE_RESET}
make -j$(nproc)

popd > /dev/null