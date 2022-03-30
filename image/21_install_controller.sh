set -e
source ./constants.sh

echo ${STYLE_BOLD} INSTALLING CONTROLLER ${STYLE_RESET}
if [[ -f ${ROOT}/controller/target/release/controller ]]; then
  cp -v ${ROOT}/controller/target/release/controller ${SYSROOT}/controller
else
  cp -v ${ROOT}/controller/target/debug/controller ${SYSROOT}/controller
fi