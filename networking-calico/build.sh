#!/usr/bin/env bash
set -eo pipefail

BUILD_BRANCH=${BUILD_BRANCH:-"master"}
DOCKERMAKE_FILE_PATH=$(pwd)/docker-make.yaml

echo "*** Cloning"

DEST_PATH="${GOPATH}/src/github.com/gardener/gardener-extension-networking-calico"
rm -rf "${DEST_PATH}"
mkdir -p "${DEST_PATH}"
git clone -b "${BUILD_BRANCH}" https://github.com/metal-stack/gardener-extension-networking-calico.git "${DEST_PATH}"

echo "*** Build and Push"

cd "${DEST_PATH}"
export BUILD_SHA=$(git log --pretty=format:'%h' -n 1)
export CONTROLLER_VERSION=$(cat ${DEST_PATH}/VERSION | tr -d " \t\n\r")

docker-make --Lint --summary -f "${DOCKERMAKE_FILE_PATH}"
