FROM php:7.2-apache

LABEL maintainer='adriangaray97@gmail.com'

ENV ADMIN_USER 'admin'

RUN docker-php-ext-install json mbstring mysqli pdo pdo_mysql

RUN apt-get update &&\
    apt-get install --no-install-recommends --assume-yes --quiet ca-certificates curl git zip unzip &&\
    rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN echo 'xdebug.idekey = PHPSTORM' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo 'xdebug.remote_port = 9000' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo 'xdebug.remote_enable = 1' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo 'xdebug.remote_connect_back = 1' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.profiler_output_dir = '/var/www/html'" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.cli_color = 1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo chmod 666 /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN groupadd containerGroup -g 3000
RUN useradd -g 3000 -m -d /home/${ADMIN_USER} -s /bin/bash ${ADMIN_USER} &&\
    usermod -g www-data ${ADMIN_USER}
RUN mkdir /home/${ADMIN_USER}/.ssh
RUN passwd ${ADMIN_USER} -d
RUN groupmod -g $(id -u ${ADMIN_USER}) www-data
