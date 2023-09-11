# Use the official WordPress image as the base
FROM wordpress:latest

# Install required PHP extensions and tools
RUN apt-get update && \
    apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install gd

# Install and configure Xdebug
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Set up WordPress debugging constants
RUN echo "define('WP_DEBUG', true);" >> /var/www/html/wp-config.php && \
    echo "define('WP_DEBUG_LOG', true);" >> /var/www/html/wp-config.php && \
    echo "define('WP_DEBUG_DISPLAY', false);" >> /var/www/html/wp-config.php && \
    echo "define('SCRIPT_DEBUG', true);" >> /var/www/html/wp-config.php

# Expose port 80
EXPOSE 80
