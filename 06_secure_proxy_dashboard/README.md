In this example we add fallow lines into docker-compose.yml:

```
services:
  traefik:
    image: traefik:v2.4
    container_name: traefik
    labels:
    .
    .
    .
    .
       - "traefik.http.routers.traefik.middlewares=auth"
       # echo $(htpasswd -nb user password) | sed -e s/\\$/\\$\\$/g
       - "traefik.http.middlewares.auth.basicauth.users=traefik:$$apr1$$pR013MIB$$ltHETm7qRT.uFaWFQ/XlN1
```

In this case we need the command htpasswd.

```
Debian based distributions:

   sudo apt-get install apache2-utils

Arch-Linux:

   sudo pacman -S apache

Centos 7:

   yum install httpd-tools
   
Centos 8 / Fedora:

   dnf install httpd-tools   
```
We can use this technik for every web entry.
