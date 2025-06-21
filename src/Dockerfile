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

COPY composer.json /var/www
COPY composer.lock /var/www

RUN composer install --no-autoloader --no-dev

COPY . /var/www

# Fix permissions for storage, bootstrap/cache, and database
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache /var/www/database && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache /var/www/database

RUN composer dump-autoload -o

RUN touch .env