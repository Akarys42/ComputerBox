set -e
source ./constants.sh

pushd ${CONTROLLER_BUILD} > /dev/null

echo ${STYLE_BOLD} BUILDING CONTROLLER ${STYLE_RESET}
PKG_CONFIG_SYSROOT_DIR=${SYSROOT} CFLAGS="--sysroot=${SYSROOT} --specs=${SYSROOT}/lib/musl-gcc.specs" cargo build --target=x86_64-unknown-linux-musl --release

popd > /dev/null