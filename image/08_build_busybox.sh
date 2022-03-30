set -e
source ./constants.sh

pushd ${BUSYBOX_BUILD} > /dev/null

echo ${STYLE_BOLD} CONFIGURING BUSYBOX ${STYLE_RESET}
make defconfig > /dev/null
${UPDATE_CONFIG} CONFIG_STATIC=y CONFIG_SYSROOT=\"$SYSROOT\" CONFIG_PREFIX=\"$SYSROOT\" "CONFIG_EXTRA_CFLAGS=\"-specs=${SYSROOT}/lib/musl-gcc.specs -L/usr/lib\""

echo ${STYLE_BOLD} BUILDING BUSYBOX ${STYLE_RESET}
make -j$(nproc)

popd > /dev/null