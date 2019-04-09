#!/bin/bash

# 强制覆盖本地代码
git fetch --all
git reset --hard
git pull

cd build
chmod +x fat.sh
./fat.sh

