source ./constants.sh
source ./commons.sh
set -e

echo ${STYLE_BOLD} DOWNLOADING MUSL ${STYLE_RESET}
download ${MUSL_DOWNLOAD} ${MUSL_FILE}

echo ${STYLE_BOLD} EXTRACTING MUSL ${STYLE_RESET}
extract ${MUSL_FILE} ${MUSL_BUILD}