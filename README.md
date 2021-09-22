# Docker Image for `vimeo/psalm`

This repository contains everything to build a simple Docker image to run [Psalm](https://github.com/vimeo/psalm/). The image will also include a few Psalm plugins.

## Building

`docker build -t mpdude/psalm .`

## Running the Image

`docker run -it --rm --init -v $(pwd):/app mpdude/psalm`, possibly followed by `psalm` arguments and options.

If you want to use `psalm-plugin` to list, enable or otherwise deal with plugins, use:

`docker run -it --rm --init -v $(pwd):/app --entrypoint=psalm-plugin mpdude/psalm`, possibly followed by `psalm-plugin` arguments and options.



