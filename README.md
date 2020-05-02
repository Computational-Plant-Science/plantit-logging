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

## Environment variables

`DIRT2_Logging` expects the following environment variables to be defined in a file called `.env` in the project root:

```
GRAYLOG_PASSWORD_SECRET=atleast16characters!
GRAYLOG_ROOT_PASSWORD_SHA2=seebelow
GRAYLOG_HTTP_EXTERNAL_URI=http://<host>:9000/
```

## Connecting

To connect to Graylog from a compose project running alongside this one:

1) Add a reference to it (Docker prefixes network names with their root project directory):

```yml
networks:
  DIRT2_Logging_graylog:
    driver: bridge
```

2) Reference from (and tag) a service, substituting the appropriate host:

```yml
some-service:
  ...
  networks:
    - DIRT2_Logging_graylog
  logging:
    driver: gelf
    options:
      gelf-address: udp://graylog:12201
      tag: "some-service"
  ...
```

To connect to Graylog from a different project type, just configure `gelf` logging and point it to `udp://<host>:12201`.
