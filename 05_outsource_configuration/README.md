Here we found follow changes:

The traefik bashboard still stays under:

 - http://dashboard.traefiklands.rocks
 - Most definations out to extern file (proxy/traefik.yml)

Static web application provides:

 - regex to forward from http:// -> http://www

Dynamic webapplication (nextcloud):

 - http://nextcloud.traefiklands.rocks

In principal static and dynamic application
works in here own docker-compose file with the
proxy network defination.
