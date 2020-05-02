#!/bin/sh

host="$1"
graylog_password="$2"
compose="docker-compose -f docker-compose.yml"

$compose down
git stash
git pull
sudo chmod +x bootstrap.sh
./bootstrap.sh
find .env -type f -exec sed -i "s/localhost/$host/g" {} \;
find .env -type f -exec sed -i "s/GRAYLOG_ROOT_PASSWORD_SHA2=*\n/$graylog_password/g" {} \;
$compose up -d