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
    sed -n '3,7p' "$1" | while IFS='' read; do
        echo "${REPLY}" >> "$2"
        git add "$2"
        git commit --quiet --author='Edward Lear <e.lear@example.com>' -m "${COMMITS:CIDX:1}"
        CIDX=$((CIDX+1))
    done
    CIDX=$((CIDX+5))
}

function _save() {
    MAIN=$(git rev-parse main)
    B1=$(git rev-parse B1)
    B2=$(git rev-parse B2)
    HEAD=$(head)

    echo 'digraph G {'

    echo 'rankdir="RL";'
    echo 'margin = .25;'
    echo 'ranksep = .3;'
    echo 'nodesep = .6;'
    echo 'edge[penwidth=2];'
    echo 'node[style=filled fillcolor="#f1f1f1" penwidth=2 fontsize=12 fontname=notosans];'

#    echo '"'""'" [style="invis" width=0 label=""];'
    echo '"'"$START"'" [style="invis" width=0 label=""];'
    echo '"origin/main" [shape = box width = .75 style = "filled" width = .5];'
    git log --topo-order --reverse --pretty='%H %s' $ORIG_MAIN $ORIG_B1 $ORIG_B2 $ORIG_HEAD main B1 B2 HEAD ^$START | while read H LABEL; do
        if [[ ${#LABEL} -gt 4 ]]; then
            WIDTH=.75
        else
            WIDTH=.5
        fi
        echo "\"$H\" [label=\"${LABEL}\" shape=circle width=$WIDTH];"
    done
    echo '"origin/main" -> "'"${UPSTREAM}"'"'
    git log --topo-order --reverse --pretty='%H %P' $ORIG_MAIN $ORIG_B1 $ORIG_B2 $ORIG_HEAD main B1 B2 HEAD ^$START| while read H PS; do
        for P in $PS; do
            echo '"'$H'" -> "'$P'";'
        done
        if [[ -z "$PS" ]]; then
            echo '"'$H'" -> "";'
        fi
    done

    echo 'subgraph cluster_main {'
    echo 'label = "main";'
    echo 'style = "invis";'
#    echo '"";'
    echo '"origin/main";'
    echo '"'"$START"'";'
    git log --pretty='"%H";' $START..$ORIG_MAIN
    echo '}'

    echo 'subgraph cluster_b1 {'
    echo 'label = "B1";'
    echo 'style = "invis";'
    git log --pretty='"%H";' "${UPSTREAM}..$ORIG_B1"
    echo '}'

    echo 'subgraph cluster_b2 {'
    echo 'label = "B2";'
    echo 'style = "invis";'
    git log --pretty='"%H";' "${UPSTREAM}..$ORIG_B2"
    echo '}'

    echo '"B1" -> "'"${B1}"'"'
    echo '"main" -> "'"${MAIN}"'"'
    echo '"B2" -> "'"${B2}"'"'
    echo '"HEAD" -> "'"${HEAD}"'"'
    echo 'B1[shape = box width = .75 style = "filled"];'
    echo 'B2[shape = box width = .75 style = "filled"];'
    echo 'main[shape = box width = .75 style = "filled"];'
    echo 'HEAD[shape = box width = .75 style = "filled"];'
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

rm -rf .git [0-9].txt
git init --quiet .
git checkout --quiet -b main
commit xx01 1.txt

START=$(git rev-parse HEAD~3)
UPSTREAM=$(git rev-parse HEAD)
commit xx04 4.txt

git checkout --quiet -b "B1" "${UPSTREAM}"
commit xx02 2.txt

git checkout --quiet -b "B2" "${UPSTREAM}"
commit xx03 3.txt

git checkout --quiet main

ORIG_MAIN=$(git rev-parse main)
ORIG_B1=$(git rev-parse B1)
ORIG_B2=$(git rev-parse B2)
ORIG_HEAD=$(head)

echo "source $(pwd)"
source "../actions.sh"
