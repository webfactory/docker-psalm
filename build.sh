#!/usr/bin/env bash
if [ $# -eq 0 ]
  then
    tag='latest'
    psalm_version='*'
  else
    tag=$1
    psalm_version=$1
fi

docker buildx build --build-arg PSALM_VERSION=$psalm_version --tag ghcr.io/webfactory/psalm:$tag --push .
