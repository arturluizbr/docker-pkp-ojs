# OJS - 
Open Journal Systems (OJS) is a journal management and publishing system that has been developed by the Public Knowledge Project through its federally funded efforts to expand and improve access to research.

Check out its [creators](https://pkp.sfu.ca) and its official [website](https://pkp.sfu.ca/ojs).

## Tags
- [latest](Dockerfile) - Tag 'ojs-3_1_1-4' of OJS repo

## Quick Run
Available options to quickly run your instance of OJS service.

## Docker Compose
For this method you'll need to have docker-compose installed on you system. Check [here](https://docs.docker.com/compose/install/) how to install docker-compose.

Steps:
- Create a folder named OJS or something else you like;
- Enter that folder you created;
- Create a *docker-compose.yml* file with contents below;
- (GUI Only) Open Terminal in the actual path;
- Run ```docker-compose up```.

Then your service will be available on [```http://localhost:8181/```](http://localhost:8181/).
```yml
# docker-compose.yml
version: "3.6"
services:
  ojs:
    build: .
    ports: 
      - 8181:80
    environment: 
      -- PKP_DATABASE_DRIVER: #TODO enviroment description=mysqli
      -- PKP_DATABASE_HOST: #TODO enviroment description=mysql
      -- PKP_DATABASE_USERNAME: #TODO enviroment description=ojs
      -- PKP_DATABASE_PASSWORD: #TODO enviroment description=ojs
      -- PKP_DATABASE_NAME: #TODO enviroment description=ojs
  mysql:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    environment: 
      - MYSQL_DATABASE=ojs
      - MYSQL_USER=ojs
      - MYSQL_PASSWORD=ojs
      - MYSQL_ROOT_PASSWORD=root

volumes: 
  db_data:
```

## Environment Variables

Basically all variables inside config.inc.php can be override with its enviroment verion.

Check the full lisk of environment variables and their description [here](ojs.config.env).

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