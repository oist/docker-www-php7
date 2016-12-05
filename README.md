This is a dockerized version of www.oist.jp using PHP7 and nginx. It will be available at www.oist.dev after this setup

## Requirements

- Docker. OSX users should be using Docker for Mac or Docker Beta and not the
virtual box based Docker machine. See https://docs.docker.com/engine/installation/mac/
- Dnsmasq to resolve "\*.oist.dev" domains to localhost.
See the README.dnsmasq.md file for reference.

## Setup

- Place the right database export in the db-seeds folder. Bear in mind that all sql **or** compressed files in that folder will be imported in the first run.
- Clone the www repository in the www folder:
```git@github.com:oist/www.git```
- Add the settings.php file from the folder drupal-extra-conf into the following path: sites/default/settings.php
```cp drupal-extra-conf/settings.php www/sites/default/settings.php```
- Build the docker images:
```
docker-compose --verbose build
```
- Run the docker containers:
```
docker-compose up
```
- To safely rebuild and restart the containers, use a combination of down, build & up.
```
docker-compose down && docker-compose up --build -d
```
