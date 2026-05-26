#!/usr/bin/env bash
set -eo pipefail


mkdir work
cd work
git clone -b "${BUILD_BRANCH}" https://github.com/metal-stack/gardener-extension-networking-cilium.git

cd gardener-extension-networking-cilium

REGISTRY=ghcr.io/metal-stack/gardener
IMAGE=gardener-extension-networking-cilium
CONTROLLER_VERSION=$(cat VERSION | tr -d " \t\n\r")

BUILD_BRANCH=${BUILD_BRANCH:-"master"}
BUILD_SHA=$(git log --pretty=format:'%h' -n 1)

docker build --build-arg BUILDPLATFORM=linux/amd64 \
    --tag "${REGISTRY}/${IMAGE}:${BUILD_BRANCH}" \
    --tag "${REGISTRY}/${IMAGE}:${BUILD_SHA}" .

docker push "${REGISTRY}/${IMAGE}:${BUILD_BRANCH}"
docker push "${REGISTRY}/${IMAGE}:${BUILD_SHA}"


docker-make --Lint --summary -f "${DOCKERMAKE_FILE_PATH}" --target gardener-extension-networking-cilium
docker-make --Lint --summary -f "${DOCKERMAKE_ADMISSION_FILE_PATH}" --target gardener-extension-admission-cilium
