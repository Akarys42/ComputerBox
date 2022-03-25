set -e
source ./constants.sh

pushd ${LIBCAP_BUILD} > /dev/null

echo ${STYLE_BOLD} BUILDING LIBCAP ${STYLE_RESET}
make CFLAGS="--sysroot=${SYSROOT} --specs=${SYSROOT}/lib/musl-gcc.specs -fPIC" -j$(nproc) libcap

popd > /dev/null