#!/bin/bash
CERT_DIR=proxy/certs

CERT=$CERT_DIR/traefik.crt
KEY=$CERT_DIR/traefik.key

if [ ! -d "$CERT_DIR" ]; then

    mkdir $CERT_DIR
    chmod 750 $CERT_DIR

fi


if [ ! -f "$CERT" ]; then

    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
            -keyout $KEY -out $CERT

   chmod 644 $CERT
   chmod 600 $KEY

fi
