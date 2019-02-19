#!/bin/bash
#
# Package for sending to a candidate
#
set -o nounset
set -e

SOURCE_DIR="$(command cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_DIR=$(/usr/bin/mktemp -d /tmp/hello-philo-XXXXXX)
TARGET_DIR="$TMP_DIR/hello-philo"
ZIP="/tmp/hello-philo.zip"

cd $SOURCE_DIR
GIT_COMMIT=$(git rev-parse HEAD)

rsync -av --exclude=".git/" --filter="dir-merge,- .gitignore" $SOURCE_DIR/ $TARGET_DIR/
cd $TARGET_DIR
rm -f package.sh
git init
git add .
git commit -m "hello-philo based on $GIT_COMMIT"

cd $TMP_DIR
rm -f $ZIP
zip -r $ZIP hello-philo 
rm -f -r $TMP_DIR

echo "$ZIP created"
