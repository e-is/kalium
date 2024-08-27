#!/bin/bash

# Get to the root project
if [[ "_" == "_${PROJECT_DIR}" ]]; then
  SCRIPT_DIR=$(dirname $0)
  PROJECT_DIR=$(cd "${SCRIPT_DIR}/.." && pwd)
  export PROJECT_DIR
fi;

cd ${PROJECT_DIR}
. scripts/version.sh  # All OS except Mac OSX

wget -c https://download.libsodium.org/libsodium/releases/$LIBSODIUM
tar xzvf $LIBSODIUM
cd ${PROJECT_DIR}/libsodium-stable && mkdir -p vendor
./configure --prefix=`pwd`/vendor
make && make install
cd ../
