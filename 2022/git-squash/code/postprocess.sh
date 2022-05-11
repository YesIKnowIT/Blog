#!/bin/bash

WIDTH=730
XWIDTH=$((15 * WIDTH / 10))

cd tmp
for f in ???.png; do
    INFILE="$f"
    OUTFILE="../$f"
    convert "${INFILE}" -gravity west -extent "${XWIDTH}" -resize "${WIDTH}" "${OUTFILE}"
done

