#!/bin/sh -l
set -e

psalm --threads=$(nproc) "$@"
