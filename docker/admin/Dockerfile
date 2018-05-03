FROM php:7.1.15-fpm
MAINTAINER Mike Bertram <bertram@nexus-netsoft.com>

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash \
 && apt-get install -y gnupg vim git curl nodejs wget sudo postgresql-common postgresql-client libpq-dev zlib1g-dev libicu-dev \
                        g++ libgmp-dev libmcrypt-dev libbz2-dev libpng-dev libjpeg62-turbo-dev \
                        libfreetype6-dev libfontconfig \
 && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) iconv pdo pgsql pdo_pgsql intl bcmath gmp bz2 zip mcrypt \
 && apt-get clean

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install -j$(nproc) gd

RUN pecl install -o -f redis \
 && docker-php-ext-enable redis

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/local/bin/composer \
 && chmod +x /usr/local/bin/composer \
 && /usr/local/bin/composer global require hirak/prestissimo

WORKDIR /data/shop/development/current

VOLUME ["/usr/local/etc/php/conf.d"]