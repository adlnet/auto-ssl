#!/bin/bash

echo "" >> ~/renew.log
echo "Checking $1 for SSL renewals ..." >> ~/renew.log

cd $1
docker-compose down

cd ./certbot

docker-compose run certbot \
        renew --webroot \
        --register-unsafely-without-email \
        --agree-tos \
        --no-random-sleep-on-renew \
        --webroot-path=/data/letsencrypt >> ~/renew.log

docker-compose down

cd ../
docker-compose up -d

echo "----------------------------------" >> ~/renew.log
echo "last run:" >> ~/renew.log
date >> ~/renew.log
