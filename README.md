# plantit-logging [![Build Status](https://travis-ci.com/Computational-Plant-Science/plantit-logging.svg?branch=master)](https://travis-ci.com/Computational-Plant-Science/plantit-logging)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Contents**

- [Usage](#usage)
- [Connecting](#connecting)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Usage

To bootstrap a development environment, run `bootstrap.sh`. Then bring containers up with `docker-compose -f docker-compose.yml up` from the project root:

- `mongo`: MongoDB instance (Graylog metadata)
- `elasticsearch`: Elasticsearch node (Graylog primary storage)
- `graylog`: Graylog server

Note that Graylog may take some time to start, and the docker container will report an unhealthy status until the web interface is up and running.

## Environment variables

`plantit-logging` expects the following environment variables to be defined in a file called `.env` in the project root:

```
GRAYLOG_PASSWORD_SECRET=atleast16characters!
GRAYLOG_ROOT_PASSWORD=some_password
GRAYLOG_ROOT_PASSWORD_SHA2=hash_of_above
GRAYLOG_HTTP_EXTERNAL_URI=http://<host>:9000/
```

Running `bootstrap.sh` from the project root will auto-generate values suitable for local development. Before deploying, be sure to change `GRAYLOG_HTTP_EXTERNAL_URI` to point to the hosts's IP or FQDN.

## Connecting

To connect to Graylog from a `docker-compose` project, just add the following configuration, substituting the appropriate host:

```yml
some-service:
  ...
  logging:
    driver: gelf
    options:
      gelf-address: udp://<host>:12201
      tag: "some-service"
  ...
```

To connect to Graylog from a different project type, just configure `gelf` logging and point it to `udp://<host>:12201`.
