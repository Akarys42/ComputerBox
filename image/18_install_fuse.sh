set -e
source ./constants.sh

pushd ${FUSE_BUILD} > /dev/null

echo ${STYLE_BOLD} INSTALLING FUSE ${STYLE_RESET}
DESTDIR=${SYSROOT} make install

popd > /dev/null
