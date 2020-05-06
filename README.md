# OJS Docker image

Open Journal Systems (OJS) is a journal management and publishing system that has been developed by the Public Knowledge Project through its federally funded efforts to expand and improve access to research.

Check out its [creators](https://pkp.sfu.ca) and its official [website](https://pkp.sfu.ca/ojs).

This particular Docker image is based on [arturluizbr/docker-pkp-ojs](https://github.com/arturluizbr/docker-pkp-ojs) but enhanced for running behind an SSL terminating proxy and for managing Docker secrets. 


## Docker Compose

For this method you'll need to have docker-compose installed on your system. Check [here](https://docs.docker.com/compose/install/) how to install docker-compose.

Steps:
- Create a `docker-compose.yml` file with contents below
- Run `docker-compose up`.

Then your service will be available on [```http://localhost:8181/```](http://localhost:8181/).
```yml
# docker-compose.yml
version: "3.6"
services:
  ojs:
    image: teic/docker-pkp-ojs
    ports: 
      - 8181:80
    environment: 
      - PKP_DATABASE_DRIVER=mysqli
      - PKP_DATABASE_HOST=ojsdb
      - PKP_DATABASE_USERNAME=ojs
      - PKP_DATABASE_PASSWORD=ojs
      - PKP_DATABASE_NAME=ojs
    restart: unless-stopped
  ojsdb:
    image: mariadb:10
    volumes:
      - db_data:/var/lib/mysql
    environment: 
      - MYSQL_DATABASE=ojs
      - MYSQL_USER=ojs
      - MYSQL_PASSWORD=ojs
      - MYSQL_RANDOM_ROOT_PASSWORD=yes
    restart: unless-stopped

volumes: 
  db_data:
```


## Environment Variables

Basically all variables inside config.inc.php can be overriden by passing the respective environment variable to the docker `run` command.

Check the full list of environment variables and their description [here](ojs.config.env).


## Docker Secrets

TODO


## Persistent Volumes

TODO


## OJS Tools

TODO


## Upgrading

Warning: **THIS PROCEDURE WAS NOT TESTED**

Steps:
- Backup and/or restore your database accoding to db image you use;
- Configure your docker-compose file to use the newest version of this image;
- Recreate your OJS container with newest version (```docker-compose up -d --force-recreate```);
- Enter the terminal mode of your container (```docker-compose exec ojs bash```);
- Run the official upgrade tool from OJS (```php -c $PHP_INI_DIR tools/upgrade.php upgrade```);


## Using your own version of OJS

To use your custom version of OJS, update the following ARGs when buiding this image.

Steps:
- Clone/Fork this repository to your workspace.
- (Docker variant) Build the image using custom ARGs (```docker build --build-arg repo_url=[YOUR-REPO] --build-arg tag_name=[YOUR_TAG_OR_BRANCH] -t user/ojs:latest .```);
- (Docker Compose variant) Update ARGs in your [```docker-compose.yml```](docker-compose.yml) file and build the image using ```docker-compose build```.
