git branch top
save 1-1.png

for((i=0;i<6;++i)); do
  NOTES["HEAD~$i"]=$(git rev-parse "HEAD~$i")
done
save 1-2.png

unset NOTES
declare -A NOTES
P=HEAD
for((i=0;i<5;++i)); do
  NOTES["$P~1"]=$(git rev-parse "$P~1")
  P="$P~1"
done
save 1-3.png
#
#sleep 1
#git commit -m "F...J"
#save 1-3.png
#
#sleep 1
#git merge --squash B1 
#git commit -m "K...O"
#save 2-1.png
#
#git checkout B2
#save 3-1.png
#
#export GIT_SEQUENCE_EDITOR='sed -i -e 2,5s/pick/squash/g'
#export VISUAL='true'
#sleep 1
#git rebase -i HEAD~5
#git commit --amend -m "P...T"
#save 3-2.png
#
#sleep 1
#git rebase main
#save 3-3.png
#
#git checkout main
#save 3-4.png
#sleep 1
#git merge --ff-only B2 -m "merge"
#save 3-5.png
