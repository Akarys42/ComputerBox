set -e
source ./constants.sh
source ./commons.sh

pushd ${MINIJAIL_BUILD} > /dev/null

echo ${STYLE_BOLD} BUILDING MINIJAIL ${STYLE_RESET}
# We would run into an error due to an already defined `old_cpp_options`
patch_specs_rename
make SYSROOT=${SYSROOT} CFLAGS="--sysroot=${SYSROOT} --specs=${SYSROOT}/lib/musl-gcc.specs" LDFLAGS="-L/usr/lib" -j$(nproc)

popd > /dev/null