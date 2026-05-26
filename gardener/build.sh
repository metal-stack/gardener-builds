#!/usr/bin/env bash
set -eo pipefail

BUILD_BRANCH=${BUILD_BRANCH:-"master"}

echo "*** Cloning"

DEST_PATH="${GOPATH}/src/github.com/gardener/gardener"
rm -rf "${DEST_PATH}"
mkdir -p "${DEST_PATH}"
git clone -b "${BUILD_BRANCH}" https://github.com/metal-stack/gardener.git "${DEST_PATH}"

echo "*** Build and Push"

cd "${DEST_PATH}"
export BUILD_SHA=$(git log --pretty=format:'%h' -n 1)

# docker-make --Lint --summary -f "${DOCKERMAKE_APISERVER_FILE_PATH}" --target apiserver
# docker-make --Lint --summary -f "${DOCKERMAKE_CONTROLLER_MANAGER_FILE_PATH}" --target controller-manager
# docker-make --Lint --summary -f "${DOCKERMAKE_SCHEDULER_FILE_PATH}" --target scheduler
# docker-make --Lint --summary -f "${DOCKERMAKE_GARDENLET_FILE_PATH}" --target gardenlet
# docker-make --Lint --summary -f "${DOCKERMAKE_NODE_AGENT_FILE_PATH}" --target node-agent
# docker-make --Lint --summary -f "${DOCKERMAKE_OPERATOR_FILE_PATH}" --target operator
# docker-make --Lint --summary -f "${DOCKERMAKE_ADMISSION_CONTROLLER_FILE_PATH}" --target admission-controller

docker build --build-arg BUILDPLATFORM=linux/amd64 \
    --target apiserver \
    --tag ghcr.io/metal-stack/gardener-builds/gardener-apiserver:"${BUILD_BRANCH}" \
    --tag ghcr.io/metal-stack/gardener-builds/gardener-apiserver:"${BUILD_SHA}" .
