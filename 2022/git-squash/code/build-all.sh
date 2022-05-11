#!/bin/bash

for f in part-*.sh; do
    DIR="${f%.sh}"
    DOT="${DIR}.dot"
    PNG="${DIR}.png"

    mkdir -p "${DIR}"

    (cd "${DIR}"; ../build-one.sh "$(dirname "${f}")/../$(basename "${f}")") | tee "${DOT}" | dot -Tpng > "${PNG}"
done
