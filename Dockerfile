FROM php:7.2-apache

LABEL maintainer='adriangaray97@gmail.com'

ENV WEB_SERVER_USER 'www-data'
ENV TRIPANDLIVE_USER 'tripandlive'

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

RUN groupadd tripandliveGroup -g 3000
RUN useradd -g 3000 -m -d /home/${TRIPANDLIVE_USER} -s /bin/bash ${TRIPANDLIVE_USER} &&\
    usermod -g www-data ${TRIPANDLIVE_USER}
RUN mkdir /home/${TRIPANDLIVE_USER}/.ssh
RUN passwd ${TRIPANDLIVE_USER} -d
RUN groupmod -g $(id -u ${TRIPANDLIVE_USER}) www-data