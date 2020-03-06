### Usage

Bring the logging system up with `docker-compose -f docker-compose.yml up` from the project root. This will start 3 containers:

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

2) Reference from a service, substituting the appropriate host:

```
some-service:
  ...
  logging:
    driver: gelf
    options:
      gelf-address: udp://<host>:12201
      tag: "postgres"
  ...
```
