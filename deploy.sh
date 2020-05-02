#!/bin/sh

host="$1"
compose="docker-compose -f docker-compose.yml"

$compose down
git stash
git pull
sudo chmod +x bootstrap.sh
./bootstrap.sh
find .env -type f -exec sed -i "s/localhost/$host/g" {} \;
$compose up -d