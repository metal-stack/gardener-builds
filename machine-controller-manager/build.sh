#!/usr/bin/env bash
set -eo pipefail

mkdir work
cd work
git clone -b "${BUILD_BRANCH}" https://github.com/metal-stack/machine-controller-manager.git

cd machine-controller-manager

REGISTRY=ghcr.io/metal-stack/gardener
IMAGE=machine-controller-manager

BUILD_BRANCH=${BUILD_BRANCH:-"master"}
BUILD_SHA=$(git log --pretty=format:'%h' -n 1)

docker build --build-arg BUILDPLATFORM=linux/amd64 \
    --tag "${REGISTRY}/${IMAGE}:${BUILD_BRANCH}" \
    --tag "${REGISTRY}/${IMAGE}:${BUILD_SHA}" .

docker push "${REGISTRY}/${IMAGE}:${BUILD_BRANCH}"
docker push "${REGISTRY}/${IMAGE}:${BUILD_SHA}"