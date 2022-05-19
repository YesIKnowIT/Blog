commit xx01 1.txt
git branch A
git branch B
commit xx02 2.txt
commit xx03 3.txt
commit xx04 4.txt

git checkout A
commit xx05 5.txt

git checkout B
commit xx06 6.txt
commit xx07 7.txt

git checkout main
git merge -m 'M' A B
git branch -D A
git branch -D B

commit xx08 8.txt
