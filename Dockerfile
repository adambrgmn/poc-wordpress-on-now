FROM wyveo/nginx-php-fpm:php72

LABEL maintainer="Adam Bergman <adam@fransvilhelm.com>"

ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf
ADD ./www /usr/share/nginx/www/

WORKDIR /usr/share/nginx/www
RUN composer install
