### Usage

`DIRT2_Logging` expects the following environment variables to be defined in a file called `.env` in the project root:

```
GRAYLOG_PASSWORD_SECRET=atleast16characters!
GRAYLOG_ROOT_PASSWORD_SHA2=seebelow
GRAYLOG_EXTERNAL_API_URL=http://<host>:9000/
```

Once you have chosen a password for the Graylog root user (note that this is *not* the same as `GRAYLOG_PASSWORD_SECRET`), `GRAYLOG_ROOT_PASSWORD_SHA2` can be generated with the following:

```bash
echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1
```

Bring the system up with `docker-compose -f docker-compose.yml up` from the project root. This will start 3 containers:

- `mongo`: MongoDB instance (Graylog metadata)
- `elasticsearch`: Elasticsearch node (Graylog primary storage)
- `graylog`: Graylog server

To connect to the `graylog` Docker network from another compose project:

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
