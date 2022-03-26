set -e
source ./constants.sh

pushd ${CONTROLLER_BUILD} > /dev/null

echo ${STYLE_BOLD} BUILDING CONTROLLER ${STYLE_RESET}
cargo build --target=x86_64-unknown-linux-musl --release

popd > /dev/null