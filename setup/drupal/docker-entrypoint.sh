#!/bin/bash
#
# Drupal container entrypoint.
#
# This entrypoint script adds settings files which can be included in a Drupal
# site's settings.php file.

set -e

# Make a directory for settings files.
mkdir -p /var/www/settings

# Write a Database connection settings file to /var/www/settings/database.php.
cat >/var/www/settings/database.php <<EOF
<?php
\$databases['default']['default'] = [
  'database' => '${DRUPAL_DATABASE_NAME:-drupal}',
  'username' => '${DRUPAL_DATABASE_USERNAME:-drupal}',
  'password' => '${DRUPAL_DATABASE_PASSWORD:-drupal}',
  'host' => '${DRUPAL_DATABASE_HOST:-mysql}',
  'port' => '${DRUPAL_DATABASE_PORT:-3306}',
  'driver' => 'mysql',
  'prefix' => '',
  'collation' => 'utf8mb4_general_ci',
  'charset' => 'utf8mb4',
];
EOF

exec "$@"
