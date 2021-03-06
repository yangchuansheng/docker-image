#!/bin/bash

git config --global credential.helper store
echo $GITHUB_USERNAME:$GITHUB_PASSWD@github.com > /root/.git-credentials

cd /opt/hugo
git pull origin master
hugo

cd /opt/envoy-handbook
git pull origin master
hugo