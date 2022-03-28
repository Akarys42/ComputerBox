#!/bin/bash
set -e
cd image

source ./constants.sh

echo ${STYLE_BOLD} STARTING BUILD ${STYLE_RESET}

for script in $(ls | grep '^[0-9]*_.*.sh'); do
  if [ ${script:0:2} -ge ${1:-0} ]; then
    ./$script
  fi
done

echo ${STYLE_BOLD} BUILD COMPLETE ${STYLE_RESET}