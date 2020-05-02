#!/bin/sh

host="$1"
graylog_root_password_sha2="$2"
compose="docker-compose -f docker-compose.yml"

$compose down
git stash
git pull
sudo chmod +x bootstrap.sh
./bootstrap.sh
find .env -type f -exec sed -i "s/localhost/$host/g" {} \;
find .env -type f -exec sed -i "s/GRAYLOG_ROOT_PASSWORD_SHA2=*\n/$graylog_root_password_sha2/g" {} \;
$compose up -d