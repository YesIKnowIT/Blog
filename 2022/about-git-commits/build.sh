#!/bin/bash

BUILDSET=(
  1:BKGND:1:1_ONLY
  2:BKGND:1:2:2_ONLY
  3:BKGND:1:2:3:3_ONLY
)

for BUILD in "${BUILDSET[@]}"; do
    IFS=: read -a LAYERS <<< "$BUILD"
    OUT="${LAYERS[0]}"
    unset LAYERS[0]
    ARGS=""
    for LAYER in "${LAYERS[@]}"; do
        ARGS="$ARGS -u //svg:g[@inkscape:groupmode='layer'][@inkscape:label='$LAYER']/@style -v display:inline"
    done

    xmlstarlet ed -P -S < master/git-objects-database.svg > "git-objects-database-$OUT.svg" \
      -N inkscape="http://www.inkscape.org/namespaces/inkscape" \
      -N svg="http://www.w3.org/2000/svg" \
      -d '//svg:g[@inkscape:groupmode="layer"]/@style' \
      -i '//svg:g[@inkscape:groupmode="layer"]' -t attr -n style -v 'display:none' \
      $ARGS
done
