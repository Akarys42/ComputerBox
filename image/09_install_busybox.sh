set -e
source ./constants.sh

pushd ${BUSYBOX_BUILD} > /dev/null

echo ${STYLE_BOLD} INSTALLING BUSYBOX ${STYLE_RESET}
make install

popd > /dev/null