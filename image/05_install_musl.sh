set -e
source ./constants.sh

pushd ${MUSL_BUILD} > /dev/null

echo ${STYLE_BOLD} INSTALLING MUSL ${STYLE_RESET}
make install
ln -s /lib/libc.so ${SYSROOT}/lib/ld-musl-x86_64.so.1 || true

popd > /dev/null