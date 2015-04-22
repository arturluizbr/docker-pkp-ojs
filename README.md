# Tags
**TO DO**

# Run
## Docker Compose
Create a *docker-compose.yml* file and run ```docker-compose up```.
```dockerfile
# docker-compose.yml
ojs:
  image: arturluizbr/pkp-ojs
  ports:
    - 80:80
  links:
    - mysql:db
mysql:
  image: mysql
  environment:
    - MYSQL_ROOT_PASSWORD=root
    - MYSQL_DATABASE=ojs
    - MYSQL_USER=ojs
    - MYSQL_PASSWORD=ojs
```

## Docker Command
Run the following commands:
```bash
# to do
```