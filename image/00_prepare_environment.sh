set -e
source ./constants.sh

echo ${STYLE_BOLD} PREPARING ENVIRONMENT ${STYLE_RESET}

mkdir -p ${SYSROOT}
mkdir -p ${DOWNLOADS}
mkdir -p ${BUILD}