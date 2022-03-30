set -e
source ./constants.sh

pushd ${CONTROLLER_BUILD} > /dev/null

echo ${STYLE_BOLD} BUILDING CONTROLLER ${STYLE_RESET}
source /usr/local/cargo/env
rustup toolchain install stable
PKG_CONFIG_SYSROOT_DIR=${SYSROOT} PKG_CONFIG_PATH=${SYSROOT}/usr/local/lib/pkgconfig CFLAGS="--sysroot=${SYSROOT} --specs=${SYSROOT}/lib/musl-gcc.specs" cargo build --release

popd > /dev/null