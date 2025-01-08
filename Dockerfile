FROM dunglas/frankenphp

# Be sure to replace "your-domain-name.example.com" by your domain name
ENV SERVER_NAME=chirp.cynetis-embedded.com
# If you want to disable HTTPS, use this value instead:
# ENV SERVER_NAME=:80

RUN install-php-extensions @composer pdo_pgsql

# Enable PHP production settings
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Copy the PHP files of your project in the public directory
#COPY . /app/public
# If you use Symfony or Laravel, you need to copy the whole project instead:
COPY . /app

RUN composer install \
  --ignore-platform-reqs \
  --optimize-autoloader \
  --prefer-dist \
  --no-interaction \
  --no-progress \
  --no-scripts
