set -e
source ./constants.sh

pushd ${MUSL_BUILD} > /dev/null

echo ${STYLE_BOLD} INSTALLING MUSL ${STYLE_RESET}
make install

popd > /dev/null