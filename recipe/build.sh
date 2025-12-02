#!/bin/bash

# Install to conda style directories
[[ -d lib/12 ]] && mv lib/12/* lib/ && rmdir lib/12
[[ -d lib/13 ]] && mv lib/13/* lib/ && rmdir lib/13

mkdir -p ${PREFIX}/lib
[[ -d pkg-config ]] && mv pkg-config ${PREFIX}/lib/pkgconfig
[[ -d "$PREFIX/lib/pkgconfig" ]] && sed -E -i "s|cudaroot=.+|cudaroot=$PREFIX|g" $PREFIX/lib/pkgconfig/nvtiff*.pc

for i in `ls`; do
    [[ $i == "build_env_setup.sh" ]] && continue
    [[ $i == "conda_build.sh" ]] && continue
    [[ $i == "metadata_conda_debug.yaml" ]] && continue
    cp -rv $i ${PREFIX}
done

check-glibc $PREFIX/lib/*.so.*
