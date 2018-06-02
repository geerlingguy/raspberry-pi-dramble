# Drupal Docker container

Use the Docker Compose file included in this directory to build and run the image as a container along with a MySQL database container.

    docker-compose up -d

The following environment variables affect what's written to the database connection settings file, and the defaults follow the variable name:

  - `DRUPAL_DATABASE_NAME=drupal`
  - `DRUPAL_DATABASE_USERNAME=drupal`
  - `DRUPAL_DATABASE_PASSWORD=drupal`
  - `DRUPAL_DATABASE_HOST=mysql`
  - `DRUPAL_DATABASE_PORT=3306`

To get your Drupal codebase into the container, you can either `COPY` it in using a Dockerfile, or mount a volume (e.g. when using the image for development). The included `docker-compose.yml` file assumes you have a Drupal codebase at the path `./web`.

## Include the Database connection settings

Since it's best practice to _not_ include secrets like database credentials in your codebase, this Docker container places connection details into special settings files, which you can include in your Drupal site's `settings.php` file.

To set up the database connection, include the following lines at the end of your `settings.php` file:

    if (file_exists('/var/www/settings/database.php')) {
      require '/var/www/settings/database.php';
    }
