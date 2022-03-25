#!/bin/bash
set -e

source ./constants.sh

echo ${STYLE_BOLD} STARTING BUILD ${STYLE_RESET}

for script in $(ls | grep '^[0-9]*_.*.sh'); do
  ./$script
done

echo ${STYLE_BOLD} BUILD COMPLETE ${STYLE_RESET}