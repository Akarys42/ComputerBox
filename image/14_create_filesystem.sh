set -e
source ./constants.sh

pushd ${SYSROOT} > /dev/null

echo ${STYLE_BOLD} CREATING FILESYSTEM ${STYLE_RESET}
mkdir -p dev bin sbin etc proc sys usr/bin usr/sbin

popd > /dev/null