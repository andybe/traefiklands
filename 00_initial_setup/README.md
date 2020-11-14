Install docker from docker.io with the community edition

We specify a bridged adapter for later:

```
docker network create proxy
```

In case we destroy the traefik container the network
should still exist.


![Network Entries](https://github.com/andybe/traefiklands/blob/main/00_initial_setup/screenshots/network_entries.png)

All sub-/domains are definded with an A record
for letsencrypt. In case of better protection remove the
wildcard entry (*).
