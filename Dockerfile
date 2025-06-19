FROM php:8.4-fpm-alpine as base

RUN docker-php-ext-install \
    mysqli \
    pdo \
    pdo_mysql \
    && true

RUN mkdir -p /var/www
WORKDIR /var/www

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer

EXPOSE 9000

FROM base as production

COPY src/composer.json /var/www
COPY src/composer.lock /var/www

RUN composer install --no-autoloader --no-dev

COPY src/ /var/www

RUN composer dump-autoload -o

RUN touch .env