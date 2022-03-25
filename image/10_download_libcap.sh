source ./constants.sh
source ./commons.sh
set -e

echo ${STYLE_BOLD} DOWNLOADING LIBCAP ${STYLE_RESET}
download ${LIBCAP_DOWNLOAD} ${LIBCAP_FILE}

echo ${STYLE_BOLD} EXTRACTING LIBCAP ${STYLE_RESET}
extract ${LIBCAP_FILE} ${LIBCAP_BUILD}