#!/bin/bash

set -e

BOOK=book-of-nonsense.txt
#DATE=1970-01-01T00:00:00
COMMITS="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
declare -i CIDX=0

function head() {
    LINK=$(git symbolic-ref --quiet HEAD || git rev-parse HEAD)
    echo ${LINK##*/}
}

function commit() {
    cat "$1" >  "$2"
    git add "$2"
    git commit --quiet --author='Edward Lear <e.lear@example.com>' -m "${COMMITS:CIDX:1}"
    CIDX=$((CIDX+1))
}

function _save() {
    for ref in "${BRANCHES[@]}"; do
        ACTUAL["$ref"]=$(git rev-parse "$ref")
    done
    ACTUAL[HEAD]=$(head)

    echo 'digraph G {'

    echo 'rankdir="RL";'
    echo 'margin = .25;'
    echo 'ranksep = .3;'
    echo 'nodesep = .6;'
    echo 'edge[penwidth=2];'
    echo 'node[style=filled fillcolor="#f1f1f1" penwidth=2 fontsize=12 fontname=notosans];'

    echo "subgraph \"cluster_root\" {"
#    echo '"'""'" [style="invis" width=0 label=""];'
    echo '"'"$START"'" [style="invis" width=0 label=""];'
#    echo '"origin/main" [shape = box width = .75 style = "filled" width = .5];'
    git log --topo-order --reverse --pretty='%H %s' "${ORIG[@]}" "${ACTUAL[@]}" ^$START | while read H LABEL; do
        if [[ ${#LABEL} -gt 4 ]]; then
            WIDTH=.75
        else
            WIDTH=.5
        fi
        echo "\"$H\" [label=\"${LABEL}\" shape=circle width=$WIDTH];"
    done
    echo '}'

#    echo '"origin/main" -> "'"${UPSTREAM}"'"'
    git log --topo-order --reverse --pretty='%H %P' "${ORIG[@]}" "${ACTUAL[@]}" ^$START| while read H PS; do
        for P in $PS; do
            echo '"'$H'" -> "'$P'";'
        done
        if [[ -z "$PS" ]]; then
            echo '"'$H'" -> "";'
        fi
    done

    for ref in "${BRANCHES[@]}"; do
        echo "subgraph \"cluster_${ref}\" {"
        echo "label = \"${ref}\";"
        echo 'style = "invis";'
        git log --pretty='"%H";' "${UPSTREAM}..${ORIG[$ref]}"
        echo '}'
    done

    for ref in "${BRANCHES[@]}" HEAD; do
        echo "\"$ref\" -> \"${ACTUAL[$ref]}\";"
        echo "\"$ref\"[shape = box width = .75 style = \"filled\"];"
    done
#    echo '{'
#    echo 'rank = same;'
#    echo '"'$ORIG_MAIN'" -> "'$ORIG_B1'" -> "'$ORIG_B2'" [style = invis];'
#    echo '}'

    echo '}'
}

function save() {
    PNG="${1}"
    DOT="${PNG%.png}.dot"
    _save | tee "${DOT}" | dot -Tpng > "${PNG}"
}

mkdir -p tmp
cd tmp

if [ ! -f "${BOOK}" ]; then
    wget 'https://www.gutenberg.org/ebooks/982.txt.utf-8' -O "${BOOK}"
fi

csplit "${BOOK}" '/^[0-9]\+\./' '{*}' > /dev/null


rm -rf .git [0-9]*.txt
git init --quiet .
git checkout --quiet -b main
git commit --allow-empty -m "Root"
START=$(git rev-parse HEAD)


source ../init.sh

BRANCHES=( $(git branch --format="%(refname:lstrip=2)") )
declare -A ORIG
declare -A ACTUAL

UPSTREAM=$(git rev-parse HEAD)

for ref in "${BRANCHES[@]}"; do
    ORIG["$ref"]=$(git rev-parse "$ref")
done
ORIG[HEAD]=$(head)

echo "source $(pwd)"
source "../actions.sh"
