#!/bin/bash

echo "Bootstrapping ${PWD##*/}..."

DOCKER_COMPOSE="docker-compose -f docker-compose.yml"

echo "Bringing containers down..."
$DOCKER_COMPOSE down

env_file=".env"
echo "Checking for environment variable file '$env_file'..."
if [ ! -f $env_file ]; then
  echo "Environment variable file '$env_file' does not exist. Creating it..."
  graylog_password_secret=($(python2 -c "exec(\"import random\nprint('%s' % ''.join(random.SystemRandom().choice('abcdefghijklmnopqrstuvwxyz0123456789!@$%^&*(-_+)') for i in range(20)))\")"))
  cat <<EOT >>$env_file
GRAYLOG_PASSWORD_SECRET=$graylog_password_secret
GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
GRAYLOG_HTTP_EXTERNAL_URI=http://localhost:9000/
EOT
else
  echo "Environment variable file '$env_file' already exists. Continuing..."
fi
