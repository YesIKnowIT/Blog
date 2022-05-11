save 1-1.png

git reset --soft "${UPSTREAM}"
save 1-2.png

git commit -m "F...J"
save 1-3.png

git merge --squash B2 
git commit -m "K...O"
save 2-1.png

git checkout B2
save 3-1.png

export GIT_SEQUENCE_EDITOR='sed -i -e 2,5s/pick/squash/g'
export VISUAL='true'
git rebase -i "${UPSTREAM}"
git commit --amend -m "P...T"
save 3-2.png

git checkout main
git merge B2 -m "merge"
save 3-3.png
