FROM geerlingguy/drupal:latest

ENV DRUPAL_VERSION 8.5.3
ENV DRUPAL_MD5 aedc6598b71c5393d30242b8e14385e5

# Download Drupal into /var/www/html.
RUN cd /var/www/html \
  && apt-get update \
  && apt-get install -y curl \
  && curl -fSL "https://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz" -o drupal.tar.gz \
  && echo "${DRUPAL_MD5} *drupal.tar.gz" | md5sum -c - \
  && tar -xz --strip-components=1 -f drupal.tar.gz \
  && rm drupal.tar.gz \
  && chown -R www-data:www-data /var/www/html \
  && rm -rf /var/lib/apt/lists/*

# Copy settings.php file into place.
RUN cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php \
  && chown www-data:www-data /var/www/html/sites/default/settings.php

# Write database settings configuration into Drupal settings.php file.
RUN echo 'if (file_exists("/var/www/settings/database.php")) {\n\
  require "/var/www/settings/database.php";\n\
}\n'\
>> /var/www/html/sites/default/settings.php

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
