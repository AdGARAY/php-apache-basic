![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/adgaray/php-apache-basic?logo=docker)

# php-apache-basic
This is a basic image of php-apache with x-debug integrated and users for www-data and for admin

## PHP extentions installed
* json
* mbstring
* mysqli
* pdo
* pdo_mysql

## Composer installed
This image is installing composer from [composer](https://getcomposer.org/installer)

## x-Debug
This image has xdebug with this settings
```console
xdebug.idekey = PHPSTORM
xdebug.remote_port = 9000
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.profiler_output_dir = '/var/www/html'
xdebug.cli_color = 1
```

## Users
* admin
* www-data
