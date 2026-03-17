#!/bin/sh -l
set -e

echo -- Disabling JIT for Psalm as a workaround for https://github.com/vimeo/psalm/issues/11723
echo -- You can ignore the JIT-related error message below
echo

PSALM_ALLOW_XDEBUG=1 /composer/vendor/bin/psalm --threads=$(nproc) "$@"
