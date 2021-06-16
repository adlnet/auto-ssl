#!/bin/bash

echo "" >> ~/renew.log
echo "Checking $1 for SSL renewals ..." >> ~/renew.log

docker-compose -f $1/docker-compose.yml stop >> ~/renew.log

certbot renew >> ~/renew.log
service nginx stop >> ~/renew.log

docker-compose -f $1/docker-compose.yml restart >> ~/renew.log

echo "----------------------------------" >> ~/renew.log
echo "last run:" >> ~/renew.log
date >> ~/renew.log
