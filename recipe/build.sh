#!/bin/bash

# Install to conda style directories
[[ -d lib/12 ]] && mv lib/12/* lib/ && rmdir lib/12
[[ -d lib/13 ]] && mv lib/13/* lib/ && rmdir lib/13

mkdir -p ${PREFIX}/lib
[[ -d pkg-config ]] && mv pkg-config ${PREFIX}/lib/pkgconfig
# Guard on the files, not the directory: the host env can provide lib/pkgconfig
# without any nvtiff*.pc (the archive ships none), and sed would fail on the bare glob.
for pc in "$PREFIX"/lib/pkgconfig/nvtiff*.pc; do
    [[ -f $pc ]] || continue
    sed -E -i "s|cudaroot=.+|cudaroot=$PREFIX|g" "$pc"
done

for i in `ls`; do
    [[ $i == "build_env_setup.sh" ]] && continue
    [[ $i == "conda_build.sh" ]] && continue
    [[ $i == "metadata_conda_debug.yaml" ]] && continue
    cp -rv $i ${PREFIX}
done

check-glibc $PREFIX/lib/*.so.*
