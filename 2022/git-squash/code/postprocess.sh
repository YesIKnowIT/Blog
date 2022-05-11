#!/bin/bash

WIDTH=730
XWIDTH=975

cd tmp
for f in ???.png; do
    INFILE="$f"
    OUTFILE="../$f"
    convert "${INFILE}" -gravity west -extent "${XWIDTH}" -background white -flatten -resize "${WIDTH}" "${OUTFILE}"
done

