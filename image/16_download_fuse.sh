source ./constants.sh
source ./commons.sh
set -e

echo ${STYLE_BOLD} DOWNLOADING FUSE ${STYLE_RESET}
download ${FUSE_DOWNLOAD} ${FUSE_FILE}

echo ${STYLE_BOLD} EXTRACTING FUSE ${STYLE_RESET}
extract ${FUSE_FILE} ${FUSE_BUILD}