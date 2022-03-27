set -e
source ./constants.sh

echo ${STYLE_BOLD} INSTALLING CONTROLLER ${STYLE_RESET}
if [[ -f ${ROOT}/controller/target/x86_64-unknown-linux-musl/release/controller ]]; then
  cp -v ${ROOT}/controller/target/x86_64-unknown-linux-musl/release/controller ${SYSROOT}/controller
else
  cp -v ${ROOT}/controller/target/x86_64-unknown-linux-musl/debug/controller ${SYSROOT}/controller
fi