Install docker from docker.io with the community edition

We specify a bridged adapter for later:

```
docker network create traefik
```

In case we destroy the traefik container the network
should still exist.

```

```
All sub-/domains are definded with an A record
for letsencrypt. In case of better protection remove the
wildcard entry (*).