# Docker Image for `vimeo/psalm`

This repository contains everything to build a simple Docker image to run [Psalm](https://github.com/vimeo/psalm/). The image will also include a few Psalm plugins.

## Building

`docker build -t psalm .`

## Running the Image

`docker run -it --rm --init -v $(pwd):/app psalm`, possibly followed by `psalm` arguments and options.

If you want to use `psalm-plugin` to list, enable or otherwise deal with plugins, use:

`docker run -it --rm --init -v $(pwd):/app --entrypoint=psalm-plugin psalm`, possibly followed by `psalm-plugin` arguments and options.

## Building for GCHR.io

This is how we build and publish the image on the GitHub Container Registry (ghcr.io).

`docker build --label org.opencontainers.image.source=https://github.com/webfactory/psalm -t ghcr.io/webfactory/psalm:latest .`

`docker push ghcr.io/webfactory/psalm:latest`


