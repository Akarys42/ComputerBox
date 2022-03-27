# Downloads a file if not already present
# Arguments: $1 = URL, $2 = file
function download() {
  if [ ! -f $2 ]; then
      wget -O $2 $1
  else
      echo ${STYLE_2}$2${STYLE_RESET} already exists
  fi
}

# Extracts a file if not already present
# Arguments: $1 = file, $2 = extract directory
function extract() {
    if [ ! -d $2 ]; then
        tar -xvf $1 -C ${BUILD} > /dev/null
    else
        echo ${STYLE_2}$2${STYLE_RESET} already exists
    fi
}

# Patches the specs file to remove the rename of cpp_options to old_cpp_options
function patch_specs_rename() {
    cp ${SYSROOT}/lib/musl-gcc.specs ${SYSROOT}/lib/musl-gcc.specs.old
    trap "mv -f ${SYSROOT}/lib/musl-gcc.specs.old ${SYSROOT}/lib/musl-gcc.specs || true" EXIT
    sed -i 's/%rename cpp_options old_cpp_options//' ${SYSROOT}/lib/musl-gcc.specs
}