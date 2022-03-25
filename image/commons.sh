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