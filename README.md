# Docker Image for `vimeo/psalm`

This repository contains everything to build a simple Docker image to run [Psalm](https://github.com/vimeo/psalm/). The image will also include a few Psalm plugins.

The image is built for the `amd64` and `arm64` platforms. A GitHub Actions workflow is used to build the image weekly, so the PHP version used should be up-to-date and new Psalm versions should show up automatically.

## Running the Published Image

The resulting image is published at https://ghcr.io/webfactory/psalm.

To use it: `docker run -it --rm --init -v $(pwd):/app ghcr.io/webfactory/psalm`, possibly followed by `psalm` arguments and options.

If you want to use `psalm-plugin` to list, enable or otherwise deal with plugins, use:

`docker run -it --rm --init -v $(pwd):/app --entrypoint=psalm-plugin ghcr.io/webfactory/psalm`, possibly followed by `psalm-plugin` arguments and options.

### Using a Cache for Psalm

If you want to use Psalm's caching feature to speed up analysis, mount a directory or Docker volume at `/cache`.

For example, run `docker run -it --rm --init -v $(pwd):/app -v $HOME/.cache:/cache ghcr.io/webfactory/psalm ...`

## Building the Image yourself

Review and/or tweak the `Dockerfile` as necessary.

Then, run `docker build -t psalm .`.

To use your own image, use `psalm` instead of `ghcr.io/webfactory/psalm` in the commands from the previous section.
