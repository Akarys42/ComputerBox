set -e
source ./constants.sh
source ./commons.sh

pushd ${FUSE_BUILD} > /dev/null

echo ${STYLE_BOLD} BUILDING FUSE ${STYLE_RESET}
patch_specs_rename
CFLAGS="--sysroot=${SYSROOT} --specs=${SYSROOT}/lib/musl-gcc.specs -no-pie" LDFLAGS="--sysroot=${SYSROOT} --specs=${SYSROOT}/lib/musl-gcc.specs -static -L/usr/lib" ./configure --with-sysroot=${SYSROOT} --disable-example
make SYSROOT=${SYSROOT} -j$(nproc)

popd > /dev/null