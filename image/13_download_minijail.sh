source ./constants.sh
source ./commons.sh
set -e

echo ${STYLE_BOLD} DOWNLOADING MINIJAIL ${STYLE_RESET}
download ${MINIJAIL_DOWNLOAD} ${MINIJAIL_FILE}

echo ${STYLE_BOLD} EXTRACTING MINIJAIL ${STYLE_RESET}
extract ${MINIJAIL_FILE} ${MINIJAIL_BUILD}