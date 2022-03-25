set -e
source ./constants.sh

pushd ${LIBCAP_BUILD} > /dev/null

echo ${STYLE_BOLD} INSTALLING LIBCAP ${STYLE_RESET}
make prefix=${SYSROOT} PAM_CAP=no lib=lib install

popd > /dev/null