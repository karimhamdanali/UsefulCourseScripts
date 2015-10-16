#! /usr/bin/env bash

organization=$1
repoName=$2

# the path to this script (i.e., the repo named UsefulCourseScripts)
pathtoscript=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# the parent folder of the organization repo on disk (you can change this to wherever you want)
base=$pathtoscript/../..

# the path to the location where you want to create the repository (you can also change this if you like)
repoLoc=$base/sastud/students/$repoName

mkdir -p $repoLoc

git clone git@github.com:$organization/$repoName.git $repoLoc

echo "cloned repository to $repoLoc"

cd $repoLoc

while read line; do
  mkdir $line

  cat $pathtoscript/$line >> $line/README.md
  git add $line/README.md
  git commit $line/README.md -m "Creating folder for $line"
done <$pathtoscript/DirNames

git push