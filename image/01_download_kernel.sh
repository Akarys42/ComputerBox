source ./constants.sh
source ./commons.sh
set -e

echo ${STYLE_BOLD} DOWNLOADING KERNEL ${STYLE_RESET}
download ${KERNEL_DOWNLOAD} ${KERNEL_FILE}

echo ${STYLE_BOLD} EXTRACTING KERNEL ${STYLE_RESET}
extract ${KERNEL_FILE} ${KERNEL_BUILD}