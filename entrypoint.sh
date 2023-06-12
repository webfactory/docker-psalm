#!/bin/sh -l
set -e

/composer/vendor/bin/psalm --threads=$(nproc) "$@"
