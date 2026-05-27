#!/usr/bin/env bash
set -eo pipefail


mkdir work
cd work
git clone -b "${BUILD_BRANCH}" https://github.com/metal-stack/gardener-extension-networking-calico.git

cd gardener-extension-networking-calico

REGISTRY=ghcr.io/metal-stack/gardener-builds
IMAGE=gardener-extension-networking-calico

BUILD_BRANCH=${BUILD_BRANCH:-"master"}
BUILD_SHA=$(git log --pretty=format:'%h' -n 1)

docker build --build-arg BUILDPLATFORM=linux/amd64 \
    --tag "${REGISTRY}/${IMAGE}:${BUILD_BRANCH}" \
    --tag "${REGISTRY}/${IMAGE}:${BUILD_SHA}" .

docker push "${REGISTRY}/${IMAGE}:${BUILD_BRANCH}"
docker push "${REGISTRY}/${IMAGE}:${BUILD_SHA}"
