set -e
source ./constants.sh

pushd ${KERNEL_BUILD} > /dev/null

echo ${STYLE_BOLD} INSTALLING HEADERS ${STYLE_RESET}
make headers_install INSTALL_HDR_PATH=${SYSROOT}

popd > /dev/null