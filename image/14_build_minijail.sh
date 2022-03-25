set -e
source ./constants.sh

pushd ${MINIJAIL_BUILD} > /dev/null

echo ${STYLE_BOLD} BUILDING MINIJAIL ${STYLE_RESET}
make SYSROOT=${SYSROOT} CFLAGS="--sysroot=${SYSROOT} --specs=${SYSROOT}/lib/musl-gcc.specs" -j$(nproc)

popd > /dev/null