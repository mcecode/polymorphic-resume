#!/bin/sh

build_files="$(dirname $(realpath "$0"))/../build/*"

if [ -z $(echo $build_files | grep -G "/../build/\*$") ]; then
  echo "Cleaning build directory"
  rm -r $build_files
else
  echo "No files or directories to delete."
fi
