#!/usr/bin/env bash
set -eo pipefail

mkdir work
cd work
git clone -b "${BUILD_BRANCH}" https://github.com/metal-stack/gardener.git

cd gardener

REGISTRY=ghcr.io/metal-stack/gardener
BUILD_BRANCH=${BUILD_BRANCH:-"master"}
BUILD_SHA=$(git log --pretty=format:'%h' -n 1)


for i in apiserver,gardener-apiserver \
         controller-manager,gardener-controller-manager \
         scheduler,gardener-scheduler \
         gardenlet,gardenlet \
         node-agent,node-agent \
         operator,operator \
         admission-controller,admission-controller; do
 
    TARGET="${i%,*}";
    IMAGE="${i#*,}";

    docker build --build-arg BUILDPLATFORM=linux/amd64 \
        --target "${TARGET}" \
        --tag "${REGISTRY}/${IMAGE}:${BUILD_BRANCH}" \
        --tag "${REGISTRY}/${IMAGE}:${BUILD_SHA}" .

    docker push "${REGISTRY}/${IMAGE}:${BUILD_BRANCH}"
    docker push "${REGISTRY}/${IMAGE}:${BUILD_SHA}"
done
