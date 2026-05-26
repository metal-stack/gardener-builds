#!/usr/bin/env bash
set -eo pipefail

BUILD_BRANCH=${BUILD_BRANCH:-"master"}
DOCKERMAKE_FILE_PATH=$(pwd)/docker-make.yaml

echo "*** Cloning"

rm -rf machine-controller-manager
git clone -b "${BUILD_BRANCH}" https://github.com/metal-stack/machine-controller-manager.git

echo "*** Build and Push"

cd machine-controller-manager
export BUILD_SHA=$(git log --pretty=format:'%h' -n 1)

docker-make --Lint --summary -f "${DOCKERMAKE_FILE_PATH}"
