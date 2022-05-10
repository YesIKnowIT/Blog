#!/bin/bash

BOOK=book-of-nonsense.txt
DATE=1970-01-01T00:00:00
COMMITS="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
declare -i CIDX=0

function commit() {
    sed -n '3,7p' "$1" | while IFS='' read; do
        echo "${REPLY}" >> "$2"
        git add "$2"
        git commit --quiet --date="${DATE}" --author='Edward Lear <e.lear@example.com>' -m "${COMMITS:CIDX:1}"
        CIDX=$((CIDX+1))
    done
    CIDX=$((CIDX+5))
}

if [ ! -f "${BOOK}" ]; then
    wget 'https://www.gutenberg.org/ebooks/982.txt.utf-8' -O "${BOOK}"
fi

csplit "${BOOK}" '/^[0-9]\+\./' '{*}' > /dev/null

rm -rf .git [0-9].txt
git init --quiet .
git checkout --quiet -b main
commit xx01 1.txt

UPSTREAM=$(git rev-parse HEAD)
commit xx04 4.txt

git checkout --quiet -b "B1" "${UPSTREAM}"
commit xx02 2.txt

git checkout --quiet -b "B2" "${UPSTREAM}"
commit xx03 3.txt

git checkout --quiet main

{
git reset --soft "${UPSTREAM}"
git add 1.txt
git commit -m "changed"
git merge B1 -m "merge B1"
} > /dev/null

MAIN=$(git rev-parse main)
B1=$(git rev-parse B1)
B2=$(git rev-parse B2)

{
    echo 'digraph G {'

    echo 'rankdir="RL";'
    echo 'margin = .25;'
    echo 'edge[penwidth=2];'
    echo 'node[style=filled fillcolor="#f1f1f1" penwidth=2 fontsize=12 fontname=notosans];'
    echo '"" [style="invis",width=0];'
    git log --pretty='"%H" [label="%s" shape=circle width=.5];' main B1 B2
    git log --pretty='"%H" -> "%P";' main B1 B2

    echo 'subgraph cluster_main {'
    echo 'label = "main";'
    echo 'style = "invis";'
    echo '"";'
    git log --pretty='"%H";' main
    echo '}'

    echo 'subgraph cluster_b1 {'
    echo 'label = "B1";'
    echo 'style = "invis";'
    git log --pretty='"%H";' "${UPSTREAM}..B1"
    echo '}'

    echo 'subgraph cluster_b2 {'
    echo 'label = "B2";'
    echo 'style = "invis";'
    git log --pretty='"%H";' "${UPSTREAM}..B2"
    echo '}'

    echo '"B1" -> "'"${B1}"'"'
    echo '"main" -> "'"${MAIN}"'"'
    echo '"B2" -> "'"${B2}"'"'
    echo '{'
#    echo 'rank = same;'
    echo 'B1[shape=box width=.75 style="filled"];'
    echo 'B2[shape=box width=.75 style="filled"];'
    echo 'main[shape=box width=.75 style="filled"];'
    echo '}'

    echo '}'
}
