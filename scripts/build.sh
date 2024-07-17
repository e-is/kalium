#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    . version.sh    # Mac OSX
else
. scripts/version.sh  # All OS except Mac OSX
fi

wget -c https://download.libsodium.org/libsodium/releases/$LIBSODIUM
tar xzvf $LIBSODIUM
cd libsodium-stable && mkdir vendor
./configure --prefix=`pwd`/vendor
make && make install
cd ../
