set -e
source ./constants.sh

pushd ${MUSL_BUILD} > /dev/null

echo ${STYLE_BOLD} CONFIGURING MUSL ${STYLE_RESET}
./configure --prefix=${SYSROOT} > /dev/null

echo ${STYLE_BOLD} BUILDING MUSL ${STYLE_RESET}
make -j$(nproc)

popd > /dev/null