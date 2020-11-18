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

openssl genrsa -out rootCA.key 4096


openssl genrsa -out traefik.key 2048

openssl req -new -sha256 \
    -key traefik.key \     
    -subj "/C=DE/ST=B/O=Traefiklands Rocks/CN=traefiklands.rocks" \
    -reqexts SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:traefiklands.rocks,DNS:*.traefiklands.rocks")) \
    -out traefik.csr 

openssl x509 -req -in traefik.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out traefik.crt -days 3650 -sha256

openssl x509 -in mydomain.com.crt -text -noout