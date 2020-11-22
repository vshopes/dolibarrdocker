
FROM php:7.3-apache-buster
RUN apt-get update -q && apt-get upgrade -yq \
    && apt-get install -yq \
        libpng-dev \
        libjpeg-dev \
        libldap2-dev \
        libxml2-dev \
        default-mysql-client \
	unzip \
	libzip-dev \
	nano \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install calendar mysqli pdo pdo_mysql gd soap zip \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap \
    && docker-php-ext-install intl

RUN mkdir /tmp/dolibarr && cd /tmp/dolibarr && \
    curl -o dolibarr.tar.gz -L "https://sourceforge.net/projects/dolibarr/files/Dolibarr%20ERP-CRM/12.0.3/dolibarr-12.0.3.tgz" && \
    tar -xzf dolibarr.tar.gz && \
    rm dolibarr.tar.gz && \
    rm -fr /var/www/html && \
    mv dolibarr-12.0.3 /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    apt-get clean && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /tmp/dolibarr

RUN curl -o composer -sL https://getcomposer.org/composer.phar && \curl -o composer -sL https://getcomposer.org/composer.phar && \ 
    cd /var/www/html && php composer install

# install mariadb
RUN apt-get update && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/* 

RUN sed -i 's/bind-address/bind-address = 0.0.0.0 #/i' /etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir /mysql_scripts
COPY mySqlScript.sql /mysql_scripts/
RUN /etc/init.d/mysql start && mysql -uroot --password="" -e "source /mysql_scripts/mySqlScript.sql"

VOLUME /var/lib/mysql
VOLUME /var/www/html

CMD /etc/init.d/mysql start && apache2-foreground
