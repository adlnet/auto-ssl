#!/bin/bash

echo "" >> ~/renew.log
echo "Checking $1 for SSL renewals ..." >> ~/renew.log

docker-compose -f $1/docker-compose.yml stop
certbot renew
docker-compose -f $1/docker-compose.yml start

echo "----------------------------------" >> ~/renew.log
echo "last run:" >> ~/renew.log
date >> ~/renew.log
