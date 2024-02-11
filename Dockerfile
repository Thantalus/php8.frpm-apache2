FROM php:8.3-rc-apache-bookworm
RUN apt-get update && apt-get upgrade -y  \
    && apt-get install -y rsync sendmail libfreetype-dev libjpeg62-turbo-dev libpng-dev libicu-dev zip libzip-dev libpq-dev libgmp-dev\
    && docker-php-ext-configure intl && docker-php-ext-install intl \
    && docker-php-ext-configure pcntl && docker-php-ext-install pcntl \
    && docker-php-ext-configure mbstring && docker-php-ext-install mbstring \
    && docker-php-ext-configure mysqli && docker-php-ext-install mysqli \
    && docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure zip && docker-php-ext-install zip \
    && docker-php-ext-configure gmp && docker-php-ext-install gmp \
    && a2enmod rewrite

EXPOSE 80

WORKDIR /var/www/html

VOLUME ["/config"]
VOLUME ["/var/www/html"]

COPY ./startup.sh /startup.sh
CMD chmod 777 /startup.sh

ENTRYPOINT "/startup.sh"
