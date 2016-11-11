#!/bin/sh

protected_branch='master'
current_branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

if [ $protected_branch = $current_branch ]
then
  echo "\033[31m WARNING: Git push to master is strictly prohibited! \033[31m"
  exit 1 # push will not execute
else
  exit 0 # push will execute
fi