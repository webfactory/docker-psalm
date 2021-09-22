FROM php:8-cli-alpine as build-extensions
RUN docker-php-ext-install pcntl posix

FROM composer:2 as composer-fetch

ENV COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_HOME="/composer"
RUN composer global require vimeo/psalm psalm/plugin-symfony psalm/plugin-phpunit weirdan/doctrine-psalm-plugin orklah/psalm-strict-types

FROM php:8-cli-alpine as runtime

COPY --from=build-extensions /usr/local/lib/php /usr/local/lib/php
COPY --from=build-extensions /usr/local/etc/php /usr/local/etc/php
COPY --from=composer-fetch /composer /composer

ENV PATH /composer/vendor/bin:${PATH}

# Satisfy Psalm's quest for a composer autoloader (with a symlink that disappears once a volume is mounted at /app)

RUN mkdir /app && ln -s /composer/vendor/ /app/vendor

# Package container

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Package container

WORKDIR "/app"
ENTRYPOINT ["/entrypoint.sh"]
