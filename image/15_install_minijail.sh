set -e
source ./constants.sh

echo ${STYLE_BOLD} INSTALLING MINIJAIL ${STYLE_RESET}
cp -v ${MINIJAIL_BUILD}/minijail0 ${SYSROOT}/bin/
cp -v ${MINIJAIL_BUILD}/{libminijail.so,libminijailpreload.so} ${SYSROOT}/lib/