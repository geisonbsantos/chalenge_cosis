# PHP 8.4 atende ao requisito PHP ^8.3 do Laravel 13.
FROM php:8.4-fpm

ARG user=user-docker
ARG uid=1000
ARG gid=1000

WORKDIR /var/www

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN apt-get update && apt-get install -y --no-install-recommends git unzip \
    && rm -rf /var/lib/apt/lists/* \
    && install-php-extensions bcmath exif gd mbstring oci8 pcntl pdo_mysql pdo_sqlite xdebug zip

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY docker/php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

RUN groupadd --gid "$gid" "$user" \
    && useradd --uid "$uid" --gid "$gid" --groups www-data --create-home "$user" \
    && mkdir -p "/home/$user/.composer" \
    && chown -R "$uid:$gid" "/home/$user" /var/www

EXPOSE 9000

CMD ["php-fpm"]
