set -e
source ./constants.sh

echo ${STYLE_BOLD} INSTALLING LIBCAP ${STYLE_RESET}
cp -v ${LIBCAP_BUILD}/libcap/libcap.so.2 ${SYSROOT}/lib/