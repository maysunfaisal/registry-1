#!/bin/sh

set -x
DEVFILES_DIR="$(pwd)/stacks/"

for devfile_dir in $(find $DEVFILES_DIR -maxdepth 1 -type d ! -path $DEVFILES_DIR); do
    devfile_name="$(basename $devfile_dir)"
    devfile_path=$devfile_dir/devfile.yaml
   
    DEVFILE_ARCHITECTURES=$(cat $devfile_path | grep architectures)

    if [ -z $DEVFILE_ARCHITECTURES ]; then
        missingDevfileArch="$missingDevfileArch$devfile_name "
    fi
done

if [ -z $DEVFILE_ARCHITECTURES ]; then
    echo devfiles with missing architectures: $missingDevfileArch
    exit 1
fi
