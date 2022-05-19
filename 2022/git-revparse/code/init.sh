git add xx01
git commit -m 'A'
git branch A
git branch B
git add xx02
git commit -m 'B'
git add xx03
git commit -m 'C'
git add xx04
git commit -m 'D'

git checkout A
git add xx05
git commit -m 'E'

git checkout B
git add xx06
git commit -m 'F'
git add xx07
git commit -m 'G'

git checkout main
git merge -m 'H' A B
git branch -D A
git branch -D B

git add xx08
git commit -m 'I'
git checkout $(git rev-parse HEAD)
git branch -D main
