FROM php:7.2.10-apache-stretch

ENV APACHE_DOCUMENT_ROOT /var/www/polr/public

RUN mkdir -p /var/www/polr

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN apt-get -qq update && \
	DEBIAN_FRONTEND=noninteractive apt-get -qq -y --no-install-recommends install \
		wget \
		curl \
		git \
		zip \
		unzip \
    &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    php -r "readfile('https://getcomposer.org/installer');" | \
    	php -- \
		--install-dir=/usr/local/bin \
		--filename=composer

RUN docker-php-ext-install pdo pdo_mysql
RUN a2enmod rewrite

WORKDIR /var/www/polr

