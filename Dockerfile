FROM php:8-cli-alpine AS build-extensions
RUN docker-php-ext-install pcntl posix
RUN apk add icu-dev 
RUN docker-php-ext-configure intl && docker-php-ext-install intl

FROM composer:2 AS composer-fetch
ARG PSALM_VERSION=*
ENV COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_MEMORY_LIMIT=-1 COMPOSER_NO_INTERACTION=1 COMPOSER_HOME="/composer"
RUN composer global require "vimeo/psalm:$PSALM_VERSION" "psalm/plugin-symfony:*" "psalm/plugin-phpunit:*" "weirdan/doctrine-psalm-plugin:*"

FROM php:8-cli-alpine AS runtime

RUN apk add icu
COPY --from=build-extensions /usr/local/lib/php /usr/local/lib/php
COPY --from=build-extensions /usr/local/etc/php /usr/local/etc/php
COPY --from=composer-fetch /composer /composer

# Satisfy Psalm's quest for a composer autoloader (with a symlink that disappears once a volume is mounted at /app)

RUN mkdir /app && ln -s /composer/vendor/ /app/vendor

# Package container

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Package container

ENV XDG_CACHE_HOME=/cache
VOLUME ["/cache"]

WORKDIR "/app"
ENTRYPOINT ["/entrypoint.sh"]

LABEL "org.opencontainers.image.source"="https://github.com/webfactory/docker-psalm"
