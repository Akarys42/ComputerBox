set -e
source ./constants.sh
source ./commons.sh

pushd ${FUSE_BUILD} > /dev/null

echo ${STYLE_BOLD} BUILDING FUSE ${STYLE_RESET}
patch_specs_rename
CFLAGS="--sysroot=${SYSROOT} --specs=${SYSROOT}/lib/musl-gcc.specs" LDFLAGS="--sysroot=${SYSROOT} --specs=${SYSROOT}/lib/musl-gcc.specs -static" ./configure --with-sysroot=${SYSROOT} --disable-example --target x86_64-pc-linux-musl --host x86_64-pc-linux-gnu
make SYSROOT=${SYSROOT} -j$(nproc)

popd > /dev/null