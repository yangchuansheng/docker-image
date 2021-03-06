#!/bin/bash

git config --global credential.helper store
echo $GITHUB_USERNAME:$GITHUB_PASSWD > /root/.git-credentials

cd /opt/hugo
git pull origin master
hugo